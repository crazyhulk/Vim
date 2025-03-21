-- local no_really = {
--     method = null_ls.methods.DIAGNOSTICS,
--     filetypes = { "markdown", "text", "go" },
--     generator = {
--         fn = function(params)
--             local diagnostics = {}
--             -- sources have access to a params object
--             -- containing info about the current file and editor state
--             for i, line in ipairs(params.content) do
--                 local col, end_col = line:find("really")
--                 if col and end_col then
--                     -- null-ls fills in undefined positions
--                     -- and converts source diagnostics into the required format
--                     table.insert(diagnostics, {
--                         row = i,
--                         col = col,
--                         end_col = end_col + 1,
--                         source = "no-really",
--                         message = "Don't use 'really!'",
--                         severity = vim.diagnostic.severity.WARN,
--                     })
--                 end
--             end
--             return diagnostics
--         end,
--     },
-- }
--
-- null_ls.register(no_really)
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

