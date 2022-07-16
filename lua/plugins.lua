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

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Plugins can have dependencies on other plugins
  -- use {
  --   'haorenW1025/completion-nvim',
  --   opt = true,
  --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  -- }
  
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
	  commit = '8ada8faf2fd5a74cc73090ec856fa88f34cd364b',
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
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-cmdline' }

  use { 'github/copilot.vim' }

  -- use { 'norcalli/nvim-colorizer.lua' }
  use { 'tpope/vim-fugitive' }
  use {	'jreybert/vimagit' }
  use { 'luochen1990/rainbow' } -- 括号颜色配对
  use { 'scrooloose/nerdtree' }
  use { 'Xuyuanp/nerdtree-git-plugin' }
  -- use { 'mileszs/ack.vim' }
  use {	'jiangmiao/auto-pairs' }
  -- use {	'junegunn/fzf.vim' }
  use {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	requires = { {'nvim-lua/plenary.nvim'} },
  }

  use {	'airblade/vim-gitgutter' }
  use {	'plasticboy/vim-markdown' }
  use {	'marko-cerovac/material.nvim' }
  -- use {	'lvht/mru' }
  use {	'mhartington/oceanic-next' }
  use {	'nvim-lua/plenary.nvim' }
  use {	'nvim-lua/popup.nvim' }
  use {	'ironhouzi/vim-stim' }
  use {	'godlygeek/tabular' }
  use {	'majutsushi/tagbar' }
  use {	'lvht/tagbar-markdown' }
  use {	'tomtom/tcomment_vim' }
  use {	'jacoborus/tender.vim' }
  use {	'vim-airline/vim-airline' }
  use {	'easymotion/vim-easymotion' }
  use {	'rakr/vim-one' }
  use {	'mhinz/vim-startify' } -- 启动页
  use {	'cespare/vim-toml' }
  use {	'hrsh7th/vim-vsnip' }
  use {	'honza/vim-snippets' }
  -- use {	'EdenEast/nightfox.nvim' } -- 主题，带状态栏
  use {
	  'nvim-telescope/telescope-fzf-native.nvim',
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
	  config = function() require('gitsigns').setup{
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

  -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}
end)
