local autocmd = vim.api.nvim_create_autocmd

-- {{{ Terminals
-- Go instantly into insert mode, ignore line numbers
autocmd({ "TermOpen" }, { command = "setlocal nonumber | normal a" })
-- }}}
