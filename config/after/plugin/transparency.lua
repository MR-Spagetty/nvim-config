-- Need to set this here so it loads after kanagawa is set up
-- This avoids the flash when transparent
vim.cmd "colorscheme catppuccin-mocha"

---- For lualine > ex.lsp
-- Needs to be here so that the stuff is actually set.
-- sets bg of the given table to the default of the line
local function linebg(hl)
  local default = vim.api.nvim_get_hl(0, { name = "StatusLine" })
  hl.bg = default.bg
  return hl
end

-- If the bg is not set, then it uses the default background which makes it inconsistent
vim.api.nvim_set_hl(0, "LspJdtls", linebg { fg = "orange" })
vim.api.nvim_set_hl(0, "LspEfm", linebg { fg = "MistyRose1" })

