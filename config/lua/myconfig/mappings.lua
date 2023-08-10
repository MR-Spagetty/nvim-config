-- TODO: Use whichkey?
vim.g.mapleader = " "

-- {{{ Nice terminal splitting: start_term(vsplit | split)
-- Settings are handled bu the autocmds
local function start_term(split_cmd)
  vim.cmd("botright " .. split_cmd .. " term://" .. vim.env.SHELL)
end
-- }}}
