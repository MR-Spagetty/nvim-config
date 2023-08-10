local autocmd = vim.api.nvim_create_autocmd

-- {{{ Terminals
-- Go instantly into insert mode, ignore line numbers
autocmd( {"TermOpen" }, { command = "setlocal nonumber | normal a" })

-- Delete the window once the program is done, avoids the press enter to exit
autocmd( {"TermClose" }, { command = "bdelete" })
-- }}}

