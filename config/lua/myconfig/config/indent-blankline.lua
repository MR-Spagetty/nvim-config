require("indent_blankline").setup({
  show_current_context = true,
  show_first_indent_level = false,
  use_treesitter = true,
})

-- {{{ AutoCMD: Make background lines darker
-- It will look kinda ugly in light themes but like that's your problem  ( ◕ ◡ ◕ ✿ )
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    -- Can't do this from the nvim API
    if vim.g.transparent_enabled then
      vim.cmd("highlight IndentBlanklineChar guifg=#202020 gui=nocombine")
    else
      vim.cmd("highlight IndentBlanklineChar guifg=#303040 gui=nocombine")
    end
  end,
})
-- }}}
