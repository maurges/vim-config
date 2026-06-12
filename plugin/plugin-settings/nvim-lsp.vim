if !has("nvim-0.5.0")
	finish
endif

lua << EOF
-- I try to support the older (around nvim 0.10-0.11) and newer lsp apis,
-- because some of my machines still use the old one. The old api uses
-- `require('lspconfig')`, new api uses `vim.lsp.config`, and they can be
-- distinguished by the presence of this function, and by the location of
-- config files
local function has_new_lspconfig(name)
	return #vim.api.nvim_get_runtime_file('lsp/' .. name .. '.lua', false) > 0
end

-- Semantic tokens is a way to provide highlighting by LSP. I hate it, and
-- neovim moves its config around all the time, so disable it in all places I
-- could find
vim.lsp.handlers['textDocument/semanticTokens/full'] = function() end
local on_init = function(client)
	client.server_capabilities.semanticTokensProvider = nil
end

-- Another compat shim because goto_next/prev were deprecated in 0.11, and
-- jump was added only recently
local diag_prev_cmd, diag_next_cmd
if vim.diagnostic.jump then
	diag_prev_cmd = '<cmd>lua vim.diagnostic.jump({count = -1, float = false})<CR>'
	diag_next_cmd = '<cmd>lua vim.diagnostic.jump({count = 1, float = false})<CR>'
else
	diag_prev_cmd = '<cmd>lua vim.diagnostic.goto_prev()<CR>'
	diag_next_cmd = '<cmd>lua vim.diagnostic.goto_next()<CR>'
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- another attempt to disable semantic tokens
	client.server_capabilities.semanticTokensProvider = nil

	-- Mappings.
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', '\\h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '\\a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '\\d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '\\e', '<cmd>lua vim.diagnostic.open_float(nil)<CR>', opts)
	buf_set_keymap('n', '[l', 'm\'' .. diag_prev_cmd, opts)
	buf_set_keymap('n', ']l', 'm\'' .. diag_next_cmd, opts)

	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

local common = {
	on_attach = on_attach,
	on_init = on_init,
	flags = { debounce_text_changes = 150 },
}
-- In new api common settings can be set once
if vim.lsp.config ~= nil then
	vim.lsp.config('*', common)
end

function setup(name, executable, settings)
	if vim.fn.executable(executable) ~= 1 then
		return false
	end
	if has_new_lspconfig(name) then
		if settings ~= nil then
			vim.lsp.config(name, { settings = settings })
		end
		vim.lsp.enable(name)
	else
		require('lspconfig')[name].setup(vim.tbl_extend('force', common, { settings = settings }))
	end
	return true
end

setup('clangd', 'clangd', nil)
setup('pylsp', 'pylsp', nil)
setup('ocamllsp', 'ocamllsp', nil)
setup('rust_analyzer', 'rust-analyzer', {
	["rust-analyzer"] = {
		files = {
			excludeDirs = { "/nix" },
		},
		cargo = {
			allFeatures = true,
		},
	},
})
setup('hls', 'haskell-language-server-wrapper', {
	haskell = {
		formattingProvider = "fourmolu",
		plugin = {
			hlint = {
				globalOn = false,
			},
			stan = {
				globalOn = false,
			},
			rename = {
				config = {
					diff = true,
				},
			},
		},
	}
})

-- Fix a bug with nvim interrupting typing randomly
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and (err.code == -32802 or err.code == -32603 or err.code == -32603) then
			return
		end
		return default_diagnostic_handler(err, result, context, config)
	end
end
-- Disable dumb distracting diagnostics
vim.diagnostic.config(
	{ underline = false
	, virtual_text = false
	, virtual_lines = false

	, update_in_insert = false
	, signs = true
	, severity_sort = true
	}
)
-- Disable the new fucking diagnostic highlights
vim.api.nvim_set_hl(0, "DiagnosticDeprecated", {})
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})

EOF

command! -nargs=0 References :lua vim.lsp.buf.references()
command! -nargs=0 SymbolRename :lua vim.lsp.buf.rename()
command! -nargs=0 -range=% Formatting :lua vim.lsp.buf.format()
