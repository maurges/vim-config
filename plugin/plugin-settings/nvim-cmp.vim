lua <<EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	completion = {
		autocomplete = false,
	},
	matching = {
		disallow_fuzzy_matching = true,
		disallow_prefix_unmatching = true,
	},
	sources = cmp.config.sources(
			{ { name = 'nvim_lsp' }
			}
		, { { name = 'buffer' }
			}
		),
	mapping = {
		['<C-J>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end,
		['<C-K>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.complete()
			end
		end,
		['<C-C>'] = function(fallback)
			if cmp.visible() then
				cmp.abort()
			else
				fallback()
			end
		end,
	},
})

_G.nvim_cmp = {
	complete = function()
		cmp.complete()
		cmp.complete_common_string()
	end
}
EOF

inoremap <C-x><C-o> <Cmd>lua nvim_cmp.complete()<CR>
