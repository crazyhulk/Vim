-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Simple plugins can be specified as strings
	-- use '9mm/vim-closer'

	-- Lazy loading:
	-- Load on specific commands
	use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

	-- Load on an autocommand event
	use {'andymass/vim-matchup', event = 'VimEnter'}

	-- Plugins can also depend on rocks from luarocks.org:
	-- use {
	--   'my/supercoolplugin',
	--   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
	-- }

	-- You can specify rocks in isolation
	-- use_rocks 'penlight'
	-- use_rocks {'lua-resty-http', 'lpeg'}

	-- Local plugins can be included
	-- use '~/projects/personal/hover.nvim'

	-- Plugins can have post-install/update hooks
	-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	-- Post-install/update hook with neovim command
	use { 'neovim/nvim-lspconfig' }

	use { 
		'nvim-treesitter/nvim-treesitter', 
		run = ':TSUpdate', 
		-- commit = '8ada8faf2fd5a74cc73090ec856fa88f34cd364b',
		-- 这个有缺点 需要 PackerSync
		-- setup = function()
		-- 	require'nvim-treesitter.configs'.setup {
		-- 	    highlight = {
		-- 	        enable = true,
		-- 	        additional_vim_regex_highlighting = false,
		-- 	    },
		-- 	    indent = {
		-- 	        -- enable = true,
		-- 	    },
		-- 	}
		-- end
	}

	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		}
	}
	use { 'hrsh7th/cmp-vsnip' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-cmdline' }
	use { 'hrsh7th/vim-vsnip' }
	-- use { 'crazyhulk/cmp-sign' }
	use  '/Users/bilibili/workspace/nvim/cmp-sign'
	use {	'honza/vim-snippets' }

	-- use { 'github/copilot.vim' }
	use {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		-- after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end,
		formatters = {
			label = require("copilot_cmp.format").format_label_text,
			insert_text = require("copilot_cmp.format").format_insert_text,
			preview = require("copilot_cmp.format").deindent,
		},
	}

	use { 'onsails/lspkind.nvim' }

	use { 'norcalli/nvim-colorizer.lua' }
	use { 'tpope/vim-fugitive' }
	use { 'jreybert/vimagit' }
	-- use {
	-- 	'altermo/ultimate-autopair.nvim',
	-- 	event={'InsertEnter','CmdlineEnter'},
	-- 	branch='v0.6', --recommended as each new version will have breaking changes
	-- 	config=function ()
	-- 		require('ultimate-autopair').setup({
	-- 			--Config goes here
	-- 		})
	-- 	end,
	-- }
	use { 'scrooloose/nerdtree' }
	use { 'Xuyuanp/nerdtree-git-plugin' }
	-- use { 'mileszs/ack.vim' }
	use {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {
				enable_check_bracket_line = false
			}
		end
	}
	-- use {	'junegunn/fzf.vim' }
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} },
	}

	use {	'airblade/vim-gitgutter', branch = 'main' }
	use {	'plasticboy/vim-markdown' }

	use {	'marko-cerovac/material.nvim' }
	use {	'mhartington/oceanic-next' }
	use {	'nvim-lua/plenary.nvim' }
	use {	'nvim-lua/popup.nvim' }
	use {	'ironhouzi/vim-stim' }
	use {	'godlygeek/tabular' }
	use {	'majutsushi/tagbar' }
	use {	'lvht/tagbar-markdown' }
	use {	'tomtom/tcomment_vim' }
	--
	-- use {	'jacoborus/tender.vim' }
	-- use {	'vim-airline/vim-airline' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {	'easymotion/vim-easymotion' }
	use {	'rakr/vim-one' }
	use {	'mhinz/vim-startify' } -- 启动页
	use {	'cespare/vim-toml' }
	-- use {	'EdenEast/nightfox.nvim' } -- 主题，带状态栏
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		-- 如果找不到 fzf.so 可能需要手动编译一下
		-- cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
	} -- 让 telescope 支持 fzf 模糊匹配（空格分词等

	use {	
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
					TypeParameter = {icon = "𝙏", hl = "TSParameter"}
				}
			} 
		end
	}

	-- Post-install/update hook with call of vimscript function with argument
	-- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

	-- Use specific branch, dependency and run lua file after load
	-- use {
	--   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
	--   requires = {'kyazdani42/nvim-web-devicons'}
	-- }

	-- Use dependency and run lua function after load
	use {
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
				status_formatter = nil, -- Use default
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
	}
	use { 'sainnhe/sonokai' }
	use { 'shaunsingh/solarized.nvim' }
	-- use { 'mfussenegger/nvim-dap' }
        --
	-- use { 
	-- 	"rcarriga/nvim-dap-ui",
	-- 	requires = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"nvim-neotest/nvim-nio"
	-- 	},
	-- 	config = function()
	-- 	end
	-- }
	-- use { 
	-- 	"folke/neodev.nvim",
	-- 	config = function()
	-- 		require("neodev").setup({
	-- 			library = { plugins = { "nvim-dap-ui" }, types = true },
	-- 		})
	-- 	end
	-- }
	-- use {
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
	-- 		-- 		-- default to string "${port}" which instructs nvim-dap
	-- 		-- 		-- to start the process in a random available port
	-- 		-- 		port = "${port}"
	-- 		-- 	},
	-- 		-- }
        --
	-- 		-- dap.adapters.go = {
	-- 		-- 	type = 'executable',
	-- 		-- 	command = 'node',
	-- 		-- 	args = {os.getenv('HOME') .. '/.vscode/extensions/golang.go-0.23.2/dist/debugAdapter.js'},
	-- 		-- }
	-- 		-- dap.configurations.go = {
	-- 		-- 	{
	-- 		-- 		type = 'go',
	-- 		-- 		name = 'Debug',
	-- 		-- 		request = 'launch',
	-- 		-- 		showLog = false,
	-- 		-- 		program = '${file}',
	-- 		-- 		dlvToolPath = vim.fn.exepath('dlv'), -- Adjust to where delve is installed
	-- 		-- 		env = {GOPATH = vim.env.GOPATH},
	-- 		-- 		args = {},
	-- 		-- 	},
	-- 		-- }
	-- 	end
	-- }

	use { 
		'python-lsp/python-lsp-server',
		config = function()
			require'lspconfig'.pylsp.setup{}
		end
	}

	-- use {
	-- 	"ray-x/lsp_signature.nvim",
	-- }

	use {
		'rcarriga/nvim-notify',
		config = function ()
			require("notify").setup {
				stages = 'fade_in_slide_out',
				timeout = 3000,
				-- Function called when a new window is opened, use for changing win settings/config
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
	}

	use {
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				-- go = {'golangcilint',}
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
	}

	use { "catppuccin/nvim", as = "catppuccin" } -- theme
	use { 'sainnhe/gruvbox-material' }

	use {
		"OXY2DEV/markview.nvim",
		lazy = false,      -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons"
		}
	}
end)
