-- My custom commands
-- See nvim_create_user_command({name}, {command}, {*opts})

local cmd = vim.api.nvim_create_user_command

cmd("Symbols", "Telescope lsp_document_symbols", {})

-- My beloved
cmd("LG", "tabnew term://lazygit | setlocal nobuflisted bufhidden=wipe", {})

-- Quick n Easy
cmd("TT", "TransparentToggle", {})
