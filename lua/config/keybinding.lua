vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F7>', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd>lua require"dap".terminate()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>Markview<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "<leader>fb", ":Telescope buffers<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>fh", ":Telescope help_tags<cr>", {})
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

