-- require('modules')
-- vim.o.background = "light"
--
require("config.lazy")
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })

require'colorizer'.setup()

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
		-- additional_vim_regex_highlighting = false,
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
	buf_set_keymap('n', 'gm', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references{}<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
	buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<cr>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<cr>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	buf_set_keymap('n', '<space>t', '<cmd>lua require("go.test").test_func()<cr>', opts)
	-- -- Set autocommands conditional on server_capabilities
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)

require'lspconfig'.gopls.setup {
	-- cmd = {'gopls', 'serve','--debug=localhost:6060', '-rpc.trace', '-logfile=/tmp/1.txt'},
	-- cmd = {'/Users/bilibili/workspace/go/xtools/gopls/gopls', 'serve','--debug=0.0.0.0:6060', '-rpc.trace', '-logfile=/tmp/1.txt'},
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
			buildFlags = {"-tags=wireinject"}, -- 添加你需要的 build tags
			-- semanticTokens = true, // 别开 坑比 影响配色
			experimentalPostfixCompletions = true,
			analyses = {
				unreachable = true, -- Disable the unreachable analyzer.
				unusedparams = true,  -- Enable the unusedparams analyzer.
				shadow = true,
				unusedvariable = true,
				staticcheck = true,
				deadcode = true,
			},
			staticcheck = true,
			-- hints = {
				-- assignVariableTypes = true,
				-- compositeLiteralFields = true,
				-- compositeLiteralTypes = true,
				-- constantValues = true,
				-- functionTypeParameters = true,
				-- parameterNames = true,
				-- rangeVariableTypes = true,
			-- },
		},
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

require('config.lualine')
require('config.vimvsnip')
require('config.theme')

-- 获取 git path
local gitRootPath = vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]")
local config = require('go.config')
config.options.test_env = {
	-- HTTP_PROXY = 'http://127.0.0.1:8888',
	-- http_proxy = 'http://127.0.0.1:8888',
	APP_ID = 'comic.comic.risk-job',
	ENV = 'uat',
	GOARCH = 'amd64',
	CONF_PATH = gitRootPath,
	MYSQL_ROOT_PASSWORD = 'root',
	ZONE = 'sh001',
	DEPLOY_ENV = 'uat',
}



-- require("config.debug")
-- require("config.lint")
-- require("config.vimtex")

require("copilot_cmp").setup()
vim.notify = require("notify")

require('lint').linters_by_ft = {
  -- markdown = {'vale',},
  -- go = {'golangcilint',},
  -- golang = {'golangcilint',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()

    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()

    -- You can call `try_lint` with a linter name or a list of names to always
    -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
    -- require("lint").try_lint("golangcilint")
  end,
})

require("config.keybinding")
