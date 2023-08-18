local g = vim.g      -- a table to access global variables

-- g.vimtex_view_method = 'zathura'
-- g.vimtex_view_general_viewer = 'okular'
-- g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
-- g.vimtex_view_method = 'xelatex'

-- g.vimtex_compile_latexmk_engines = {
--   _ = '-xelatex',
-- }
-- g.vimtex_compiler_latexmk_engines = { ["_"] = "echo %S && -xelatex -f && dvisvgm --zoom=-1 --exact --font-format=woff --output=%DIR%/%B.svg %S" }
g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex && dvisvgm --zoom=-1 --exact --font-format=woff *.xdv" }
g.vimtex_compiler_method = "/Applications/Google Chrome.app"
g.vimtex_compiler_latexmk = {
    options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
