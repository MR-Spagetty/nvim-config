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
-- }}}
--[[ TODO: Add processing extension
-- {{{ Processing LSP
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "processing",
  callback = function()
    -- Start the LSP
    vim.lsp.start {
      name = "processing-lsp",
      cmd = { "/usr/share/processing/processing-lsp" },
      root_dir = vim.fs.dirname(vim.fs.find(function(name)
        return name:match ".*%.pde$"
      end, { type = "file" })[0]),
    }

  end,
})
-- }}} ]]
-- }}}
