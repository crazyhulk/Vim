-- require('modules')
-- vim.o.background = "light"
--
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

require'colorizer'.setup()
require'gitsigns'.setup()

require'nvim-treesitter.configs'.setup {
	defaults = {
		generic_sorter = require'telescope.sorters'.get_fzy_sorter,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "+",
			scope_incremental = "0",
			node_decremental = "-",
		},
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
}

require('telescope').setup{
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('aerial')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references{}<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
	buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<cr>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	buf_set_keymap('n', '<space>t', '<cmd>lua require("go.test").test_func()<cr>', opts)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
	end
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
capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)

require'lspconfig'.gopls.setup {
	cmd = {'gopls'},
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		gopls = {
			-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#completion
			-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings 补全命令
			-- https://github.com/hrsh7th/vim-vsnip#2-setting
			usePlaceholders = true,
			experimentalPostfixCompletions = true,
			analyses = {
				unreachable = true, -- Disable the unreachable analyzer.
				unusedparams = true,  -- Enable the unusedparams analyzer.
				shadow = true,
				unusedvariable = true,
			},
		staticcheck = true,
		},
		-- staticcheck = true,
	},
}

require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.sourcekit.setup{
    on_attach = on_attach,
    capabilities = capabilities,
	-- root_dir = root_pattern("Package.swift", ".git")	
}

require "lsp_signature".setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded"
	}
})

require('config.lualine')
require('config.vimvsnip')
-- require('config.theme')

-- 获取 git path
local gitRootPath = vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]")
local config = require('go.config')
config.options.test_env = {
	GOARCH = 'amd64',
	CONF_PATH = gitRootPath,
	MYSQL_ROOT_PASSWORD = 'root'
}

-- Attaches to every FileType mode
-- require 'colorizer'.setup()
-- require('material').setup()


-- print("=========111", cmd("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]"))
-- print("=========111", vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]"))

-- Find files using Telescope command-line sugar.
-- vim.api.nvim_set_keymap('n', "<leader>ff", ":Telescope find_files<cr>", {})
-- vim.api.nvim_set_keymap('n', "<leader>fg", ":Telescope live_grep<cr>", {})
vim.api.nvim_set_keymap('n', "<leader>fb", ":Telescope buffers<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>fh", ":Telescope help_tags<cr>", {})
-- vim.api.nvim_set_keymap('n', "<leader>ff", ":Telescope find_files", {})
-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>

-- Using Lua functions
vim.api.nvim_set_keymap('n', '<Leader>ff',  ":lua require('telescope.builtin').find_files({find_command=ag,hidden=false, no_ignore=true})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fds',  ":lua require('telescope.builtin').lsp_document_symbols()<CR>", {})
vim.api.nvim_set_keymap('n', '<Leader>fws',  ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", {})
vim.api.nvim_set_keymap('n', '<Leader>fg',  [[<Cmd>lua require('telescope.builtin').live_grep({find_command=ag})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fo',  [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>	

vim.api.nvim_set_keymap('n', '<Leader>vh',  [[<Cmd>lua require('telescope.builtin').command_history()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>fs',  ":SymbolsOutline <CR>", {})
vim.api.nvim_set_keymap('n', '<Leader>ct',  ":Copilot panel<CR>", {})

require("config.debug")
require("config.lint")

-- require('plenary.reload').reload_module('plenary') -- 重新加载 Plenary.vim 模块
-- vim.cmd('hi DiagnosticError guifg=#ff0000') -- 配置诊断错误的颜色
-- vim.cmd('hi DiagnosticWarn guifg=#ff8800') -- 配置诊断警告的颜色
-- vim.cmd('hi DiagnosticInfo guifg=#00ffff') -- 配置诊断信息的颜色
-- vim.cmd('hi DiagnosticHint guifg=#00ff00') -- 配置诊断提示的颜色

vim.cmd('hi DiagnosticVirtualTextError guifg=#ff0000 ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextWarn guifg=#ff8800 ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextInfo guifg=#00ffff ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextHint guifg=#00ff00 ctermfg=red')

