require('material').setup({
	contrast = {
		terminal = false, -- Enable contrast for the built-in terminal
		sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		cursor_line = false, -- Enable darker background for the cursor line
		non_current_windows = false, -- Enable darker background for non-current windows
		filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
	},

	styles = { -- Give comments style such as bold, italic, underline etc.
		-- comments = {  italic = true,underline = true },
		strings = { --[[ bold = true ]] },
		keywords = { --[[ underline = true ]] },
		functions = { --[[ bold = true, undercurl = true ]] },
		variables = {},
		operators = {},
		types = {},
	},

	plugins = { -- Uncomment the plugins that you use to highlight them
		-- Available plugins:
		-- "dap",
		-- "dashboard",
		-- "gitsigns",
		-- "hop",
		-- "indent-blankline",
		-- "lspsaga",
		-- "mini",
		-- "neogit",
		-- "neorg",
		"nvim-cmp",
		-- "nvim-navic",
		-- "nvim-tree",
		-- "nvim-web-devicons",
		-- "sneak",
		"telescope",
		-- "trouble",
		-- "which-key",
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between verticaly split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false -- Enable higher contrast text for darker style
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

	custom_colors = nil, -- If you want to everride the default colors, set this to a function

	custom_highlights = {}, -- Overwrite highlights with your own
})
vim.cmd 'colorscheme material'

require('plenary.reload').reload_module('plenary') -- 重新加载 Plenary.vim 模块
vim.cmd('hi DiagnosticError guifg=#ff0000') -- 配置诊断错误的颜色
vim.cmd('hi DiagnosticWarn guifg=#ff8800') -- 配置诊断警告的颜色
vim.cmd('hi DiagnosticInfo guifg=#00ffff') -- 配置诊断信息的颜色
vim.cmd('hi DiagnosticHint guifg=#00ff00') -- 配置诊断提示的颜色

vim.cmd('hi DiagnosticVirtualTextError guifg=#ff0000 ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextWarn guifg=#ff8800 ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextInfo guifg=#00ffff ctermfg=red')
vim.cmd('hi DiagnosticVirtualTextHint guifg=#00ff00 ctermfg=red')

