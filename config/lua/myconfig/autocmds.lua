local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- {{{ Terminals
-- Go instantly into insert mode, ignore line numbers
autocmd({ "TermOpen" }, { command = "setlocal nonumber | normal a" })
-- }}}

--- {{{ Toggle relative numbers
-- Toggle relative numbers, on for insert, off by default.
augroup("ToggleRNu", { clear = true })
autocmd({ "InsertEnter" }, {
  command = "setlocal norelativenumber",
  group = "ToggleRNu"
})
autocmd({ "InsertLeave" }, {
  command = "setlocal relativenumber",
  group = "ToggleRNu"
})
-- }}}
