CmpConfig = {}

CmpConfig.init = function(Cmp,LuaSnip)
	local select_opts = { behavior = Cmp.SelectBehavior.Select }

	Cmp.setup({
		snippet = {
			expand = function(args)
				LuaSnip.lsp_expand(args.body)
			end
		},
		sources = {
			{ name = 'nvim_lsp', keyword_length = 2 },
			{ name = 'path',     keyword_length = 2 },
			{ name = 'buffer',   keyword_length = 2 },
			{ name = 'luasnip',  keyword_length = 2 },
		},
		mapping = {
			['<CR>'] = Cmp.mapping.confirm({
				behavior = Cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<Tab>"] = Cmp.mapping(function(fallback)
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				local hasWordsBefore = col ~= 0 and
					vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

				if Cmp.visible() then
					Cmp.select_next_item()
				elseif hasWordsBefore then
					Cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = Cmp.mapping(function(fallback)
				if Cmp.visible() then
					Cmp.select_prev_item()
				elseif LuaSnip.jumpable(-1) then
					LuaSnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}
	})

	local function confirmDone(evt)
		local context = evt.entry.context
		if not vim.tbl_contains({ 'php', 'lua' }, context.filetype) then
			return
		end

		if vim.startswith(context.cursor_after_line, '(') then
			return
		end

		local endRange = evt.entry.source_insert_range['end']
		vim.treesitter.get_parser(context.bufnr):parse({ endRange.line, endRange.line })
		local node = vim.treesitter.get_node({ pos = { endRange.line, endRange.character - 1 } })

		local methodNodeTypes = { 'class_constant_access_expression', 'member_access_expression' }

		if vim.tbl_contains(methodNodeTypes, node:parent():type()) then
			vim.api.nvim_feedkeys('(', 'i', false)
		end
	end

	Cmp.event:on('confirm_done', confirmDone)

end

return CmpConfig
