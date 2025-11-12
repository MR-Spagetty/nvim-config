-- Function from https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
--  This lets lualine use gitsigns to get git info
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

require("lualine").setup {
  options = {
    theme = "auto",
    component_separators = { left = "╱", right = "│" },

    section_separators = { left = "", right = nil },

    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename", "branch" },
    lualine_c = { { "diff", source = diff_source }, "diagnostics" },
    lualine_x = {
      {
        "ex.lsp.all",
        icons = {
          unknown = "!",
          lsp_is_off = "",
          ["efm"] = { "󰣖", color = "LspEfm" },
          ["tsserver"] = { "󰛦", color = "LspTsserver" },
          ["pyright"] = { "", color = "LspPyright" },
        },
        only_attached = true,
      },
      "encoding",
      {
        "fileformat",
        -- Show this instead of OS icons
        symbols = {
          unix = "LF",
          dos = "CRLF",
          -- CURSED????
          mac = "CR",
        },
      },
      { "filetype", icons_enabled = false },
    },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
}
