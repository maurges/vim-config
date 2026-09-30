if !has("nvim-0.12.0")
	finish
endif

lua << EOF
-- Semantic tokens is a way to provide highlighting by LSP. I hate it, and
-- neovim moves its config around all the time, so disable it in all places I
-- could find
vim.lsp.handlers['textDocument/semanticTokens/full'] = function() end
local on_init = function(client)
	client.server_capabilities.semanticTokensProvider = nil
end

local function on_jump(diagnostic, bufnr)
	if not diagnostic then return end
	vim.cmd("normal! m'")
	vim.diagnostic.open_float({
		bufnr = bufnr,
		scope = 'cursor',
		focus = false,
	})
end
local diag_prev = function() vim.diagnostic.jump({count=-1, on_jump=on_jump}) end
local diag_next = function() vim.diagnostic.jump({count=1, on_jump=on_jump}) end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- another attempt to disable semantic tokens
	client.server_capabilities.semanticTokensProvider = nil

	-- Mappings.
	local opts = { remap=false, silent=true, buf=bufnr }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', '\\h', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '\\a', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', '\\d', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '\\e', function() vim.diagnostic.open_float(nil) end, opts)
	vim.keymap.set('n', '[l', diag_prev, opts)
	vim.keymap.set('n', ']l', diag_next, opts)

	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

vim.lsp.config('*', {
	on_attach = on_attach,
	on_init = on_init,
	flags = { debounce_text_changes = 150 },
})

function setup(name, executable, settings)
	if vim.fn.executable(executable) ~= 1 then
		return false
	end
	if settings ~= nil then
		vim.lsp.config(name, { settings = settings })
	end
	vim.lsp.enable(name)
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
