-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
	-- import your plugins
	-- { import = "plugins" },
	{ 'neovim/nvim-lspconfig' },

	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	},

	{ 'hrsh7th/cmp-nvim-lsp' },
	{
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		},
	},
	{ 'hrsh7th/cmp-vsnip' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/vim-vsnip' },
	{ 'crazyhulk/cmp-sign' },
	{	'honza/vim-snippets' },

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				server_opts_overrides = {
					-- trace = "verbose",
					settings = {
						advanced = {
							listCount = 10, -- #completions for panel
							inlineSuggestCount = 10, -- #completions for getCompletions
						},
					},
				},
				filetypes = {
					go = true,
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		-- after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end,
		-- formatters = {
		-- 	label = require("copilot_cmp.format").format_label_text,
		-- 	insert_text = require("copilot_cmp.format").format_insert_text,
		-- 	preview = require("copilot_cmp.format").deindent,
		-- },
	},

	{ 'onsails/lspkind.nvim' },

	{ 'norcalli/nvim-colorizer.lua' },
	{ 'tpope/vim-fugitive' },
	{ 'jreybert/vimagit' },
	{ 'scrooloose/nerdtree' },
	{ 'Xuyuanp/nerdtree-git-plugin' },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {
				enable_check_bracket_line = false
			}
		end
	},
	--   {	'junegunn/fzf.vim' },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'}, },
	},

	{	'airblade/vim-gitgutter', branch = 'main' },
	{	'plasticboy/vim-markdown' },

	{	'marko-cerovac/material.nvim' },
	{	'mhartington/oceanic-next' },
	{	'nvim-lua/plenary.nvim' },
	{	'nvim-lua/popup.nvim' },
	{	'ironhouzi/vim-stim' },
	{	'godlygeek/tabular' },
	{	'majutsushi/tagbar' },
	{	'lvht/tagbar-markdown' },
	{	'tomtom/tcomment_vim' },
	--
	--   {	'jacoborus/tender.vim' },
	--   {	'vim-airline/vim-airline' },
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	},
	{	'easymotion/vim-easymotion' },
	{	'rakr/vim-one' },
	{	'mhinz/vim-startify' }, -- 启动页
	{	'cespare/vim-toml' },
	--   {	'EdenEast/nightfox.nvim' }, -- 主题，带状态栏
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- 如果找不到 fzf.so 可能需要手动编译一下
		-- cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
	}, -- 让 telescope 支持 fzf 模糊匹配（空格分词等

	{
			'simrat39/symbols-outline.nvim',
			config = function()
				-- init.lua
				vim.g.symbols_outline = {
					highlight_hovered_item = true,
					show_guides = true,
					auto_preview = true,
					position = 'right',
					relative_width = true,
					width = 25,
					auto_close = false,
					show_numbers = false,
					show_relative_numbers = false,
					show_symbol_details = true,
					preview_bg_highlight = 'Pmenu',
					keymaps = { -- These keymaps can be a string or a table for multiple keys
						close = {"<Esc>", "q"},
						goto_location = "<Cr>",
						focus_location = "o",
						hover_symbol = "<C-space>",
						toggle_preview = "K",
						rename_symbol = "r",
						code_actions = "a",
					},
					lsp_blacklist = {},
					symbol_blacklist = {},
					symbols = {
						File = {icon = "", hl = "TSURI"},
						Module = {icon = "", hl = "TSNamespace"},
						Namespace = {icon = "", hl = "TSNamespace"},
						Package = {icon = "", hl = "TSNamespace"},
						Class = {icon = "𝓒", hl = "TSType"},
						Method = {icon = "ƒ", hl = "TSMethod"},
						Property = {icon = "", hl = "TSMethod"},
						Field = {icon = "", hl = "TSField"},
						Constructor = {icon = "", hl = "TSConstructor"},
						Enum = {icon = "ℰ", hl = "TSType"},
						Interface = {icon = "ﰮ", hl = "TSType"},
						Function = {icon = "", hl = "TSFunction"},
						Variable = {icon = "", hl = "TSConstant"},
						Constant = {icon = "", hl = "TSConstant"},
						String = {icon = "𝓐", hl = "TSString"},
						Number = {icon = "#", hl = "TSNumber"},
						Boolean = {icon = "⊨", hl = "TSBoolean"},
						Array = {icon = "", hl = "TSConstant"},
						Object = {icon = "⦿", hl = "TSType"},
						Key = {icon = "🔐", hl = "TSType"},
						Null = {icon = "NULL", hl = "TSType"},
						EnumMember = {icon = "", hl = "TSField"},
						Struct = {icon = "𝓢", hl = "TSType"},
						Event = {icon = "🗲", hl = "TSType"},
						Operator = {icon = "+", hl = "TSOperator"},
						TypeParameter = {icon = "𝙏", hl = "TSParameter"},
					},
				}
			end
	},

	--   dependency and run lua function after load
	{
		'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup{
				-- signs = {
				--   add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
				--   change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
				--   delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
				--   topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
				--   changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
				-- },
				signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
				numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, --   default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = 'single',
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1
				},
				yadm = {
					enable = false
				},
			}
		end
	},
	{ 'sainnhe/sonokai' },
	{ 'shaunsingh/solarized.nvim' },
	--   { 'mfussenegger/nvim-dap' },
	--
	--   { 
	-- 	"rcarriga/nvim-dap-ui",
	-- 	requires = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"nvim-neotest/nvim-nio"
	-- 	},
	-- 	config = function()
	-- 	end
	-- },
	--   { 
	-- 	"folke/neodev.nvim",
	-- 	config = function()
	-- 		require("neodev").setup({
	-- 			library = { plugins = { "nvim-dap-ui" }, types = true },
	-- 		},)
	-- 	end
	-- },
	--   {
	-- 	'leoluz/nvim-dap-go',
	-- 	config = function()
	-- 		-- local dap = require('dap-go')
	-- 		-- dap.setup {
	-- 		-- 	-- Additional dap configurations can be added.
	-- 		-- 	-- dap_configurations accepts a list of tables where each entry
	-- 		-- 	-- represents a dap configuration. For more details do:
	-- 		-- 	-- :help dap-configuration
	-- 		-- 	dap_configurations = {
	-- 		-- 		{
	-- 		-- 			-- Must be "go" or it will be ignored by the plugin
	-- 		-- 			type = "go",
	-- 		-- 			name = "Attach remote",
	-- 		-- 			mode = "remote",
	-- 		-- 			request = "attach",
	-- 		-- 		},
	-- 		-- 	},
	-- 		-- 	-- delve configurations
	-- 		-- 	delve = {
	-- 		-- 		-- time to wait for delve to initialize the debug session.
	-- 		-- 		-- default to 20 seconds
	-- 		-- 		initialize_timeout_sec = 20,
	-- 		-- 		-- a string that defines the port to start delve debugger.
	-- 		-- 		-- default to string "${port}," which instructs nvim-dap
	-- 		-- 		-- to start the process in a random available port
	-- 		-- 		port = "${port},"
	-- 		-- 	},
	-- 		-- },
	--
	-- 		-- dap.adapters.go = {
	-- 		-- 	type = 'executable',
	-- 		-- 	command = 'node',
	-- 		-- 	args = {os.getenv('HOME') .. '/.vscode/extensions/golang.go-0.23.2/dist/debugAdapter.js'},
	-- 		-- },
	-- 		-- dap.configurations.go = {
	-- 		-- 	{
	-- 		-- 		type = 'go',
	-- 		-- 		name = 'Debug',
	-- 		-- 		request = 'launch',
	-- 		-- 		showLog = false,
	-- 		-- 		program = '${file},',
	-- 		-- 		dlvToolPath = vim.fn.exepath('dlv'), -- Adjust to where delve is installed
	-- 		-- 		env = {GOPATH = vim.env.GOPATH},
	-- 		-- 		args = {},
	-- 		-- 	},
	-- 		-- },
	-- 	end
	-- },

	{
		'python-lsp/python-lsp-server',
		config = function()
			require'lspconfig'.pylsp.setup{}
		end
	},

	--   {
	-- 	"ray-x/lsp_signature.nvim",
	-- },

	{
		'rcarriga/nvim-notify',
		config = function ()
			require("notify").setup {
				stages = 'fade_in_slide_out',
				timeout = 3000,
				-- Function called when a new window is opened,   for changing win settings/config
				on_open = nil,

				-- Function called when a window is closed
				on_close = nil,

				-- Render function for notifications. See notify-render()
				render = "default",


				-- For stages that change opacity this is treated as the highlight behind the window
				-- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
				background_colour = "Normal",

				-- Minimum width for notification windows
				minimum_width = 50,

				-- Icons for the different levels
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			}
			vim.notify = require('notify')
		end
	},

	{
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				-- go = {'golangcilint',},
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()

					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()

					-- You can call `try_lint` with a linter name or a list of names to always
					-- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("golangcilint")
				end,
			})
		end
	},

	{ "catppuccin/nvim", as = "catppuccin" }, -- theme
	{ 'sainnhe/gruvbox-material' },

	{
		"OXY2DEV/markview.nvim",
		lazy = false,      -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons"
		},
	},

	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
