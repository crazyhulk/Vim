-- require('modules')
-- vim.o.background = "light"
--
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- require'colorizer'.setup()
require'gitsigns'.setup()

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        -- enable = true,
    },
}

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

-- print(nvim_win_get_width(0))
print(vim.api.nvim_win_get_width(0))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

require'lspconfig'.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

-- 获取 git path
gitRootPath = vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]")
local config = require('go.config')
config.options.test_env = {
	CONF_PATH = gitRootPath,
	MYSQL_ROOT_PASSWORD = 'root'
}

-- Attaches to every FileType mode
-- require 'colorizer'.setup()
-- require('material').setup()


-- print("=========111", cmd("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]"))
-- print("=========111", vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]"))
