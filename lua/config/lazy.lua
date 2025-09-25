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
		{
			'neovim/nvim-lspconfig' ,
			dependencies = { 'saghen/blink.cmp' },

			-- example using `opts` for defining servers
			opts = {
				inlay_hints = { enabled = true },
				servers = {
					lua_ls = {}
				}
			},
			config = function(_, opts)
				local lspconfig = require('lspconfig')
				for server, config in pairs(opts.servers) do
					-- passing config.capabilities to blink.cmp merges with the capabilities in your
					-- `opts[server].capabilities, if you've defined it
					config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
					lspconfig[server].setup(config)
				end
			end

			-- example calling setup directly for each LSP
			-- config = function()
			-- 	local capabilities = require('blink.cmp').get_lsp_capabilities()
			-- 	local lspconfig = require('lspconfig')
			--
			-- 	lspconfig['lua-ls'].setup({ capabilities = capabilities })
			-- end
		},

		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			dependencies = { "OXY2DEV/markview.nvim" },
			lazy = false, -- load treesitter immediately
		},

		-- { 'hrsh7th/cmp-nvim-lsp' },
		-- {
		-- 	'hrsh7th/nvim-cmp',
		-- },
		-- { 'hrsh7th/cmp-vsnip' },
		-- { 'hrsh7th/cmp-path' },
		-- { 'hrsh7th/cmp-buffer' },
		-- { 'hrsh7th/cmp-cmdline' },
		-- { 'hrsh7th/vim-vsnip' },
		{	'honza/vim-snippets' },

		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			opts = {
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>"
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					go = true,
					yaml = false,
					markdown = true,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = 'node', -- Node.js version must be > 18.x
				server_opts_overrides = {},
			},
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
			opts = {
				-- enable check bracket line
				enable_check_bracket_line = false,
			},
		},
		--   {	'junegunn/fzf.vim' },
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies =  {'nvim-lua/plenary.nvim'},
		},

		{ 'airblade/vim-gitgutter', branch = 'main' },
		{ 'plasticboy/vim-markdown' },

		{ 'marko-cerovac/material.nvim' },
		{ 'mhartington/oceanic-next' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-lua/popup.nvim' },
		{ 'ironhouzi/vim-stim' },
		{ 'godlygeek/tabular' },
		{ 'majutsushi/tagbar' },
		{ 'lvht/tagbar-markdown' },
		{ 'tomtom/tcomment_vim' },
		--
		--   {	'jacoborus/tender.vim' },
		--   {	'vim-airline/vim-airline' },
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
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
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
		}, -- 让 telescope 支持 fzf 模糊匹配（空格分词等

		--   dependency and run lua function after load
		{
			'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' },
			opts = {
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
			},
		},
		{ 'sainnhe/sonokai' },
		{ 'shaunsingh/solarized.nvim' },
		{ dir = '~/workspace/neovim/calltree/' },
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

		--   {
		-- 	"ray-x/lsp_signature.nvim",
		-- },

		{
			'rcarriga/nvim-notify',
			opts = {
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
			},
			config = function ()
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

		-- add blink.compat
		{
			'saghen/blink.compat',
			-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
			version = '*',
			-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
			lazy = true,
			-- make sure to set opts so that lazy.nvim calls blink.compat's setup
			opts = {},
		},

		{
			'saghen/blink.cmp',
			-- optional: provides snippets for the snippet source
			dependencies = {
				{
					"fang2hou/blink-copilot",
					opts = {
						max_completions = 3,  -- Global default for max completions
						max_attempts = 3,     -- Global default for max attempts
					}
				},
				{ 'rafamadriz/friendly-snippets'},
				{ 'crazyhulk/cmp-sign' },
			},

			-- use a release tag to download pre-built binaries
			version = '*',
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' for mappings similar to built-in completion
				-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
				-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
				-- See the full "keymap" documentation for information on defining your own keymap.
				keymap = {
					preset = 'default',
					['<enter>'] = { 'accept', 'fallback'},
				},

				appearance = {
					-- Sets the fallback highlight groups to nvim-cmp's highlight groups
					-- Useful for when your theme doesn't support blink.cmp
					-- Will be removed in a future release
					use_nvim_cmp_as_default = true,
					-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = 'mono',
					kind_icons = {
						Copilot = "",
						Text = '󰉿',
						Method = '󰊕',
						Function = '󰊕',
						Constructor = '󰒓',

						Field = '󰜢',
						Variable = '󰆦',
						Property = '󰖷',

						Class = '󱡠',
						Interface = '󱡠',
						Struct = '󱡠',
						Module = '󰅩',

						Unit = '󰪚',
						Value = '󰦨',
						Enum = '󰦨',
						EnumMember = '󰦨',

						Keyword = '󰻾',
						Constant = '󰏿',

						Snippet = '󱄽',
						Color = '󰏘',
						File = '󰈔',
						Reference = '󰬲',
						Folder = '󰉋',
						Event = '󱐋',
						Operator = '󰪚',
						TypeParameter = '󰬛',
					},
				},

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { --[['nvim_cmp_sign', --]] 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
					per_filetype = { go = { 'nvim_cmp_sign', 'lsp', 'path', 'snippets', 'buffer', 'copilot' } },
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-copilot",
							score_offset = 100,
							async = true,
							opts = {
								-- These options are passed to the source's setup function
								-- See `:help blink-copilot` for more information
								max_completions = 3,  -- Max number of completions to request and show
								max_attempts = 3,     -- Max number of attempts to get completions
							},
							-- transform_items = function(_, items)
							-- 	local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							-- 	local kind_idx = #CompletionItemKind + 1
							-- 	CompletionItemKind[kind_idx] = "Copilot"
							-- 	for _, item in ipairs(items) do
							-- 		item.kind = kind_idx
							-- 	end
							-- 	return items
							-- end,
						},
						nvim_cmp_sign = {
							name = "nvim_cmp_sign",
							-- module = "cmp_sign",
							module = 'blink.compat.source',
							-- score_offset = -3,
							-- async = true,
							opts = {
								cache_nvim_cmp_sign_on_start = true
							}
						},
					},
				},
				signature = { enabled = true },
				completion = {
					ghost_text = { enabled = true },
					menu = { --[[border = 'single', --]] auto_show = true },
					documentation = { auto_show = true, window = { border = 'single' } },
					trigger = {
						show_on_keyword = true,
						show_on_insert_on_trigger_character = true,
						show_on_accept_on_trigger_character = true,
					},
					list = {
						selection = { preselect = false, auto_insert = true }
					},
				}
			},

			opts_extend = { "sources.default" }
		},

		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			---@type snacks.Config
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				animate = {
					      duration = { step = 10, total = 100 },
					      easing = "in_out_cubic", -- 示例：缓入缓出效果
				},
				-- refer to the configuration section below
				bigfile = { enabled = false },
				dashboard = { enabled = true },
				explorer = { enabled = true },
				-- indent = { enabled = true },
				input = { enabled = true },
				picker = { enabled = true },
				notifier = { enabled = true },
				quickfile = { enabled = true },
				scope = { enabled = true },
				scroll = { enabled = true },
				-- statuscolumn = { enabled = true },
				-- words = { enabled = true },
			}
		},
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			lazy = false,
			-- enabled = false,
			version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
			opts = {
				provider = "copilot",
				-- provider = "claude", -- The provider to use for Avante, can be 'openai', 'deepseek', 'copilot', 'claude', etc.
				auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot

				providers = {
					deepseek = {
						__inherited_from = 'openai',
						api_key_name = "OPENAI_API_KEY",
						endpoint = "https://api.deepseek.com",
						model = "deepseek-coder",
					},
					---@type AvanteSupportedProvider
					openai = {
						api_key_name = "OPENAI_API_KEY",
						endpoint = "https://api.deepseek.com/v1",
						-- model = "deepseek-chat",
						model = "deepseek-coder",
						timeout = 30000, -- Timeout in milliseconds
						extra_request_body = {
							temperature = 0,
							max_tokens = 4096,
						}
					},
					copilot = {
						endpoint = "https://api.githubcopilot.com",
						model = "claude-3.7-sonnet",
						-- model = "claude-sonnet-4",
						-- model = "gpt-4o-2024-08-06",
						allow_insecure = false, -- Allow insecure server connections
						timeout = 30000, -- Timeout in milliseconds
						extra_request_body = {
							temperature = 0,
							max_tokens = 8192,
						}
					},
					claude = {
						-- endpoint = "https://api.anthropic.com",
						endpoint = "https://api.oaipro.com/",
						model = "claude-sonnet-4-20250514",
						timeout = 30000, -- Timeout in milliseconds
						extra_request_body = {
							temperature = 0.75,
							max_tokens = 20480,
						},
					},
				}
			},
			-- opts = {
			-- 	-- add any opts here
			-- 	provider = "copilot",
			-- 	model = "Claude 3.5 Sonnet",
			-- 	copilot = {
			-- 		endpoint = "https://api.githubcopilot.com",
			-- 		model = "claude-3.5-sonnet",
			-- 		-- model = "gpt-4o-2024-08-06",
			-- 		proxy = nil, -- [protocol://]host[:port] Use this proxy
			-- 		allow_insecure = false, -- Allow insecure server connections
			-- 		timeout = 30000, -- Timeout in milliseconds
			-- 		temperature = 0,
			-- 		max_tokens = 4096,
			-- 	},
			-- },
			-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
			build = "make BUILD_FROM_SOURCE=true",
			-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
			dependencies = {
				"folke/snacks.nvim",
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				--- The below dependencies are optional,
				"echasnovski/mini.pick", -- for file_selector provider mini.pick
				"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
				-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
				"ibhagwan/fzf-lua", -- for file_selector provider fzf
				"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
				"zbirenbaum/copilot.lua", -- for providers='copilot'
				{
					-- support for image pasting
					"HakonHarnes/img-clip.nvim",
					event = "VeryLazy",
					opts = {
						-- recommended settings
						default = {
							embed_image_as_base64 = false,
							prompt_for_file_name = false,
							drag_and_drop = {
								insert_mode = true,
							},
							-- required for Windows users
							use_absolute_path = true,
						},
					},
				},
				{
					-- Make sure to set this up properly if you have lazy=true
					'MeanderingProgrammer/render-markdown.nvim',
					opts = {
						file_types = { "markdown", "Avante" },
					},
					ft = { "markdown", "Avante" },
				},
			},
		},
		{
			"jinzhongjia/LspUI.nvim",
			branch = "main",
			config = function()
				require("LspUI").setup({
					inlay_hint = {
						enable = false,
						command_enable = true,
						filter = {
							whitelist = {},
							blacklist = {},
						},
					}
					-- config options go here
				})
			end
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			branch = "master",
			config = function()
				require'treesitter-context'.setup{
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					multiwindow = false, -- Enable multiwindow support.
					max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
					min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
					line_numbers = true,
					multiline_threshold = 20, -- Maximum number of lines to show for a single context
					trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
					-- Separator between context and content. Should be a single character string, like '-'.
					-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
					separator = nil,
					zindex = 20, -- The Z-index of the context window
					on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
				}
			end
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
