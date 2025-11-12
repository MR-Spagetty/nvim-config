local telescope = require "telescope"

telescope.setup {
  -- From https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
  defaults = vim.tbl_extend(
    "force",
    require("telescope.themes").get_ivy {
      layout_config = { height = 12 },
      borderchars = {
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
    },
    {
      mappings = {
        i = {
          ["<C-k>"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
          ["<C-h>"] = "which_key",
        },
      },
    }
  ),
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    project = {
      base_dirs = {
        { "~/projects", max_depth = 4 },
      },
      order_by = "recent",
      sync_with_nvim_tree = true,
    },
  },
}

telescope.load_extension "ui-select"
telescope.load_extension "fzf"

