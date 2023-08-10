local wk = require("which-key")
vim.g.mapleader = " "

-- TODO: Change the prefix = <leader> to the corresponding one. E.g. <leader>g
-- {{{ Nice terminal splitting: start_term(vsplit | split)
-- Settings are handled bu the autocmds
local function start_term(split_cmd)
  vim.cmd("botright " .. split_cmd .. " term://" .. vim.env.SHELL)
end
-- }}}

-- {{{ Terminal starting
wk.register({
  v = {
    v = { function() start_term("vsplit") end, "Vertical terminal" }
  },
  h = {
    h = { function() start_term("vsplit") end, "Horizontal terminal" }
  },
}, { prefix = '<leader>' })
-- }}}

-- {{{ Git
wk.register({
  g = {
    name = "Git",
    -- Open fugitive to the right
    g = { "<cmd>Git<cr><C-w>L", "Fugitive" },
    b = { "<cmd>Gitsigns blame_line<cr>", "Show blame" },
    s = { "<cmd>Telescope git_status<cr>", "Git status" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
    p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
  },
}, { prefix = '<leader>' })
-- }}}

-- {{{ Commenting
wk.register({
  ["/"] = { function() require("Comment.api").toggle.linewise.current() end, "Comment" }
}, { prefix = '<leader>' })

wk.register({
  ["/"] = { function()
    -- From the Comment.nvim documentation
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
  end, "Comment" }
}, { mode = { "v" }, prefix = '<leader>' })
-- }}}

-- {{{ Toggles
wk.register({
  name = "Toggles",
  s = { "<cmd>set spell!<cr>", "Toggle spellcheck" },
}, { prefix = '<leader>t' })
---}}}

-- {{{ TODO: Telescope
-- }}}

