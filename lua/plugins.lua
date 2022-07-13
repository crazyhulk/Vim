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
  use { 'luochen1990/rainbow' }
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
  use {	'mhinz/vim-startify' }
  use {	'cespare/vim-toml' }
  use {	'hrsh7th/vim-vsnip' }
  use {	'jreybert/vimagit' }
  use {	'honza/vim-snippets' }


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
  	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
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
