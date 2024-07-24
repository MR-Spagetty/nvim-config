---@diagnostic disable: missing-fields
require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "markdown", "markdown_inline", "lua", "vim", "vimdoc", "query" },
  auto_install = true,
  highlight = { enable = true },
}
