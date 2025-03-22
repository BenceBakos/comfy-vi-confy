return {
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      
      -- Useful status updates for LSP
      { 
        'j-hui/fidget.nvim', 
        opts = {
          -- Use modern config for fidget.nvim to avoid deprecation warnings
          notification = {
            window = {
              winblend = 0, -- make transparent
            },
          },
        },
        tag = "legacy", -- Use legacy tag to avoid API changes
      },
      
      -- For formatters and linters
      'jose-elias-alvarez/null-ls.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    config = function()
      -- Setup Mason to automatically install LSP servers
      require('mason').setup({
        -- Avoid deprecated functions
        ui = {
          check_outdated_packages_on_open = true,
          border = "rounded",
        }
      })
      
      -- Custom installation function for extra tools
      local function ensure_installed(package_name)
        local registry = require('mason-registry')
        if not registry.is_installed(package_name) then
          vim.cmd('MasonInstall ' .. package_name)
        end
      end
      
      -- Set up common LSP servers through Mason
      require('mason-lspconfig').setup({
        ensure_installed = {
          'dockerls',      -- Dockerfile
          'yamlls',        -- YAML
          'intelephense',  -- PHP (fallback if phpactor fails)
          'bashls',        -- Bash
          'rnix',          -- Nix
          'lemminx',       -- XML
          'html',          -- HTML
          'cssls',         -- CSS
          'pyright',       -- Python
          'lua_ls',        -- Lua
        },
        automatic_installation = true,
      })
      
      -- Manually install phpactor since it's not in Mason-lspconfig
      vim.defer_fn(function()
        ensure_installed('phpactor')
      end, 100)
      
      -- Configure LSP servers
      local lspconfig = require('lspconfig')
      
      -- Configure lua language server
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              -- Fix for deprecated vim.tbl_add_reverse_lookup
              -- Use explicit library path instead of vim.api.nvim_get_runtime_file
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      
      -- PHP specific settings using both phpactor and intelephense for redundancy
      -- First try to set up phpactor if it's available
      vim.defer_fn(function()
        local registry = require('mason-registry')
        if registry.is_installed('phpactor') then
          -- Get the package and installation path
          local package = registry.get_package('phpactor')
          local phpactor_bin = package:get_install_path() .. "/bin/phpactor"
          
          -- Check if the binary exists and is executable
          if vim.fn.filereadable(phpactor_bin) == 1 then
            -- Configure phpactor only if it's installed and executable
            lspconfig.phpactor.setup({
              -- Use modern configuration
              init_options = {
                -- Enable all plugins by default
                ["language_server_phpstan.enabled"] = true,
                ["language_server_psalm.enabled"] = true,
                ["language_server.diagnostics_on_update"] = true,
                ["language_server.diagnostics_on_save"] = true,
                ["language_server.diagnostics_on_open"] = true,
                
                -- Enable auto-import
                ["code_transform.import_globals"] = true,
                ["code_transform.fix_namespace_class_name"] = true,
                
                -- Use composer autoloader if available
                ["composer.autoloader_path"] = "%project_root%/vendor/autoload.php",
                
                -- PHP version
                ["php_version"] = "8.2.0",
              },
              
              -- Set capabilities
              capabilities = vim.lsp.protocol.make_client_capabilities(),
              
              -- Use exact path to the binary
              cmd = { phpactor_bin, "language-server" },
            })
            
            vim.notify("Phpactor configured successfully", vim.log.levels.INFO)
          else
            vim.notify("Phpactor binary not found, falling back to intelephense", vim.log.levels.WARN)
          end
        else
          vim.notify("Phpactor not installed, falling back to intelephense", vim.log.levels.WARN)
        end
      end, 500)
      
      -- Configure intelephense as a fallback with WordPress support
      lspconfig.intelephense.setup({
        settings = {
          intelephense = {
            environment = {
              phpVersion = "8.2.0"
            },
            files = {
              maxSize = 5000000,  -- Larger file size limit for WordPress
              associations = { "*.php", "*.module", "*.inc", "*.theme" },
              exclude = {
                "**/.git/**",
                "**/.svn/**",
                "**/node_modules/**",
                "**/vendor/**/vendor/**",
                "**/wp-includes/**",  -- Skip WordPress core files for better performance
              }
            },
            stubs = {
              "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
              "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter",
              "fpm", "ftp", "gd", "hash", "iconv", "imap", "intl", "json", "ldap",
              "libxml", "mbstring", "mcrypt", "meta", "mysqli", "oci8", "odbc", "openssl",
              "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite",
              "pgsql", "Phar", "posix", "pspell", "readline", "recode", "Reflection",
              "regex", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium",
              "SPL", "sqlite3", "standard", "superglobals", "sybase", "sysvmsg", "sysvsem",
              "sysvshm", "tidy", "tokenizer", "wddx", "wordpress", "xml", "xmlreader",
              "xmlrpc", "xmlwriter", "Zend OPcache", "zip", "zlib"
            },
            completion = {
              insertUseDeclaration = true,
              fullyQualifyGlobalConstantsAndFunctions = false,
              maxItems = 100,
            },
            format = {
              enable = false  -- Let null-ls handle formatting
            },
          }
        },
        -- Set a larger workspace memory limit for WordPress projects
        init_options = {
          storagePath = vim.fn.stdpath("cache") .. "/intelephense",
          globalStoragePath = vim.fn.stdpath("cache") .. "/intelephense",
          licenceKey = nil,
          clearCache = false,
          memoryLimit = 4096, -- 4GB for WordPress projects
        }
      })
      
      -- Set up keymaps for LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { noremap = true, silent = true, buffer = ev.buf }
          
          -- LSP keybindings
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gof', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', 'gm', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', 'gM', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', 'gF', function() vim.lsp.buf.format { async = true } end, opts)
        end,
      })
      
      -- Formatting 
      -- Try to install phpactor directly from Mason
      vim.defer_fn(function() 
        ensure_installed('phpactor')
        ensure_installed('php-cs-fixer')
        ensure_installed('phpstan')
      end, 200)
      
      -- Set up formatters and linters
      require('mason-null-ls').setup({
        ensure_installed = {
          'prettier', -- JS, TS, CSS, HTML, JSON, YAML, Markdown
          'stylua',   -- Lua
          'black',    -- Python
          'shellcheck',  -- Bash
          'shfmt',       -- Bash
        },
        automatic_installation = true,
        handlers = {},
      })
      
      -- Set up null-ls with configuration to avoid deprecation warnings
      local null_ls = require("null-ls")
      
      -- Use modern API for builtins
      null_ls.setup({
        sources = {
          -- Add sources manually for better control
          -- PHP formatting
          require("null-ls").builtins.formatting.phpcsfixer.with({
            -- Use temp directory in user's cache
            cwd = function()
              return vim.fn.stdpath("cache") .. "/null-ls"
            end,
            -- Don't try to look for config in WordPress directories
            args = function(params)
              return {
                "--no-interaction",
                "--quiet",
                "--rules=@PSR12",
                "fix",
                "$FILENAME",
              }
            end,
          }),
          -- PHP diagnostics - only use if needed
          null_ls.builtins.diagnostics.phpstan.with({
            cwd = function()
              return vim.fn.stdpath("cache") .. "/null-ls"
            end,
            -- Use a basic level and don't require a config file
            args = { "analyze", "--level=3", "--no-progress", "--error-format=raw", "$FILENAME" },
          }),
          -- Add other sources from mason-null-ls
        },
        -- Set a dedicated temp directory that the user has access to
        temp_dir = vim.fn.stdpath("cache") .. "/null-ls",
        -- Add debug logging to troubleshoot issues
        debug = true,
        -- Use newer vim.lsp.buf methods
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                -- Use newer vim.lsp.buf.format instead of deprecated functions
                pcall(function()
                  vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
                end)
              end,
            })
          end
        end,
      })
      
      -- Create the temp directory with proper permissions
      vim.fn.mkdir(vim.fn.stdpath("cache") .. "/null-ls", "p", 0700)
    end,
  },
  
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      -- Load luasnip properly to avoid deprecation warnings
      require("luasnip.loaders.from_snipmate").lazy_load()
      
      -- Set up nvim-cmp with modern configuration
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', keyword_length = 2 },
          { name = 'path',     keyword_length = 2 },
          { name = 'buffer',   keyword_length = 1 },
          { name = 'luasnip',  keyword_length = 2 },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            
            -- Use modern API for cursor check
            local line = vim.api.nvim_get_current_line()
            local hasWordsBefore = col > 0 and line:sub(col, col):match("%s") == nil
            
            if cmp.visible() then
              cmp.select_next_item()
            elseif hasWordsBefore then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Use modern formatting
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              path = "[Path]",
              buffer = "[Buffer]",
              luasnip = "[Snippet]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
}
