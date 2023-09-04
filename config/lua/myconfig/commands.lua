-- My custom commands
-- See nvim_create_user_command({name}, {command}, {*opts})

local cmd = vim.api.nvim_create_user_command

cmd("Symbols", "Telescope lsp_document_symbols", {})

-- My beloved
cmd("LG", "tabnew term://lazygit | setlocal nobuflisted bufhidden=wipe", {})

-- Quick n Easy
cmd("TT", "TransparentToggle", {})

-- I CAN'T STOP DOING THIS AAAGHGHGHB
cmd("W", "w", {})

-- {{{ Telescope symbols
cmd("Kaomoji", function()
  require("telescope.builtin").symbols { sources = { "kaomoji" } }
end, {})
cmd("Emoji", function()
  require("telescope.builtin").symbols { sources = { "emoji" } }
end, {})
cmd("MathUnicode", function()
  require("telescope.builtin").symbols { sources = { "math" } }
end, {})
cmd("MathLatex", function()
  require("telescope.builtin").symbols { sources = { "latex" } }
end, {})
-- }}}

