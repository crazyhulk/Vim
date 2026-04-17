require("config.lazy")

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })

-- 关闭鼠标
vim.opt.mouse = ""

require'colorizer'.setup()
vim.notify = require("notify")


-- require("copilot_cmp").setup()
require('config.lsp')
require('config.lualine')
require('config.vimvsnip')
require('config.theme')
require('config.gotest')
require("config.pytest")
require("config.keybinding")
require("config.cr")
-- require("config.debug")
-- require("config.lint")
-- require("config.vimtex")

-- vim.lsp.inlay_hint.enable(true)

-- Example: Setup for diagnostics in Neovim
-- vim.diagnostic.config({
--     virtual_text = true,  -- Enable inline diagnostics in the editor
--     signs = true,         -- Show signs in the sign column
--     underline = true,     -- Underline diagnostics
--     update_in_insert = false, -- Disable diagnostics while typing
--     severity_sort = true  -- Sort diagnostics by severity
-- })
