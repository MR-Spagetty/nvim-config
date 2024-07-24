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

local telebuilt = require "telescope.builtin"
local wk = require "which-key"
wk.register({
  name = "Telescope",
  f = { telebuilt.find_files, "Find files" },
  F = {
    function()
      telebuilt.find_files { no_ignore = true, no_ignore_parent = true, hidden = true }
    end,
    "Find files",
  },
  -- h = { "<cmd>Telescope harpoon marks<cr>", "Harpoon marks" },
  g = { telebuilt.live_grep, "Live grep" },
  a = { telebuilt.builtin, "Telescope builtins" },
  t = { telebuilt.treesitter, "Treesitter symbols" },
  q = { telebuilt.quickfix, "Quickfix" },
  l = { telebuilt.loclist, "Location list" },
  p = { telebuilt.oldfiles, "Previous files" },
  b = { telebuilt.buffers, "Open buffers" },
  j = { telebuilt.jumplist, "Jump list" },
  h = { telebuilt.help_tags, "Help tags" },
  m = { telebuilt.man_pages, "Man pages" },
  o = { require("cd-project.adapter").cd_project, "Search projects" },
  d = { vim.cmd.TodoTelescope, "Find TODOs" },
  ["/"] = { telebuilt.current_buffer_fuzzy_find, "Fuzzy find" },
}, { prefix = "<leader>f" })
