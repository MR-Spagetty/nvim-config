local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- {{{ Terminals
-- Go instantly into insert mode, ignore line numbers
autocmd({ "TermOpen" }, {
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.signcolumn = "no"
    vim.cmd.startinsert()
  end,
})
-- }}}

--- {{{ Toggle relative numbers
-- Toggle relative numbers, on for insert, off by default.
augroup("ToggleRNu", { clear = true })
autocmd({ "InsertEnter" }, {
  -- command = "setlocal norelativenumber",
  callback = function()
    if vim.o.number then
      vim.o.relativenumber = false
    end
  end,
  group = "ToggleRNu",
})
autocmd({ "InsertLeave" }, {
  callback = function()
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
  group = "ToggleRNu",
})
-- }}}

-- {{{ File specific
-- {{{ Java makeprg gradle || java
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "java",
  callback = function()
    if vim.fn.filereadable "build.gradle" == 1 then
      vim.bo.makeprg = "gradle run"
    else
      vim.bo.makeprg = "java %"
    end
  end,
})

---- For lualine > ex.lsp
-- Check https://codeyarns.com/tech/2011-07-29-vim-chart-of-color-names.html for colors.
-- If the bg is not set, then it uses the default background which makes it inconsistent
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    local default = vim.api.nvim_get_hl(0, { name = "StatusLineNC" })
    vim.api.nvim_set_hl(0, "LspJdtls", { fg = "orange", bg = default.bg })
    vim.api.nvim_set_hl(0, "LspEfm", { fg = "MistyRose1", bg = default.bg })
    vim.api.nvim_set_hl(0, "LspTsserver", { fg = "SteelBlue", bg = default.bg })
    vim.api.nvim_set_hl(0, "LspPyright", { fg = "gold1", bg = default.bg })
  end,
})
