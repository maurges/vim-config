if !has("nvim-0.5.0")
	finish
endif

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', '\\h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '\\a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '\\n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '\\e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[l', 'm\'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']l', 'm\'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

function setup(name, executable, settings)
	if vim.fn.executable(executable) == 1 then
		-- setup for completion
		local capabilities = require('cmp_nvim_lsp').update_capabilities(
			vim.lsp.protocol.make_client_capabilities()
		)

		nvim_lsp[name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			settings = settings,
		}
	end
end

setup('clangd', 'clangd', nil)
setup('pylsp', 'pylsp', nil)
setup('rls', 'rls', nil)
setup('ocamllsp', 'ocamllsp', nil)
setup('hls', 'haskell-language-server', {
	haskell = {
		formattingProvider = "stylish-haskell",
		plugin = {
			hlint = {
				globalOn = false,
			},
		},
	}
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = false
		, virtual_text = false
		, signs = true
		}
	)
EOF

cabbrev <expr> diag (getcmdpos() == 5 && getcmdtype() == ":") ? "lua vim.lsp.diagnostic.set_loclist()" : "diag"
cabbrev <expr> refs (getcmdpos() == 5 && getcmdtype() == ":") ? "lua vim.lsp.buf.references()" : "refs"
