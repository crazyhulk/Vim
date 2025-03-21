require("config.lazy")

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })

require'colorizer'.setup()
vim.notify = require("notify")


-- require("copilot_cmp").setup()
require('config.lsp')
require('config.lualine')
require('config.vimvsnip')
require('config.theme')
require('config.gotest')
require("config.keybinding")
-- require("config.debug")
-- require("config.lint")
-- require("config.vimtex")
