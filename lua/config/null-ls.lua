require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		-- require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.code_actions.gitsigns,
		-- require("null-ls").builtins.diagnostics.golangci_lint,
		require("null-ls").builtins.diagnostics.revive.with({
			args = {  "-config", vim.fn.expand("~/.config/nvim/revive.toml"),"-formatter", "json", "./..."},
		}),
		-- require("null-ls").builtins.formatting.gofmt,
		-- require("null-ls").builtins.formatting.goimports,
	},
})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
end

local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer', options = { get_bufnrs = vim.api.nvim_list_bufs } },
    },
    mapping = {
	['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
	['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

require'lspconfig'.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

require'lspconfig'.sourcekit.setup{
    on_attach = on_attach,
    capabilities = capabilities,
	-- root_dir = root_pattern("Package.swift", ".git")	
}


-- 这里为了解决 null-ls 跟 gopls 的冲突 是 0.7.0 的方案
-- 参考 https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08

local util = require 'vim.lsp.util'

local formatting_callback = function(client, bufnr)
	vim.keymap.set('n', '<leader>f', function()
		local params = util.make_formatting_params({})
		client.request('textDocument/formatting', params, nil, bufnr)
	end, { buffer = bufnr })
end

local servers = {'gopls'}
for _, server in ipairs(servers) do
	require'lspconfig'[server].setup {
		on_attach = function(client, bufnr)
			if client.name ~= 'gopls' then
				formatting_callback(client, bufnr)
			end
			-- common_on_attach(client, bufnr)
			on_attach(client, bufnr)
		end
	}
end
