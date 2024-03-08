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

end

return CmpConfig
