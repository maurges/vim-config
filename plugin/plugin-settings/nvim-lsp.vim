if !has("nvim-0.5.0")
	finish
endif

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	local opts = { noremap=true, silent=true }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', '\\h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '\\a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '\\d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '\\e', '<cmd>lua vim.diagnostic.open_float(nil)<CR>', opts)
	buf_set_keymap('n', '[l', 'm\'<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']l', 'm\'<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

	vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Disable lsp-server adding highlighting
	client.server_capabilities.semanticTokensProvider = nil
end

function setup(name, executable, settings)
	if vim.fn.executable(executable) == 1 then
		nvim_lsp[name].setup {
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			settings = settings,
		}
		return true
	else
		return false
	end
end

setup('clangd', 'clangd', nil)
setup('pylsp', 'pylsp', nil)
setup('ocamllsp', 'ocamllsp', nil)
-- special setup with fallback for rust
local _ = setup('rust_analyzer', 'rust-analyzer', nil) or setup('rls', 'rls', nil)
-- setup for haskell with settings
setup('hls', 'haskell-language-server-wrapper', {
	haskell = {
		formattingProvider = "hindent",
		plugin = {
			hlint = {
				globalOn = false,
			},
		},
	}
})
-- special setup with cmd for rescript
if vim.fn.executable('node') == 1 then
	nvim_lsp.rescriptls.setup {
		cmd = {'node', vim.env.HOME .. '/.local/share/atom-ide-rescript/vendor/server/out/server.js', '--stdio'},
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = false
		, virtual_text = false
		, signs = true
		}
	)

EOF

command! -nargs=0 Diagnostics :lua vim.lsp.diagnostic.set_loclist()
command! -nargs=0 References :lua vim.lsp.buf.references()
command! -nargs=0 SymbolRename :lua vim.lsp.buf.rename()
command! -nargs=0 -range=% Formatting :lua vim.lsp.buf.format()
