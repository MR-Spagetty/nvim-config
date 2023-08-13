require("nvim-tree").setup {
  hijack_cursor = true,
  hijack_netrw = true,
  sort = {
    sorter = "filetype",
    folders_first = true,
  },
  -- reload_on_bufenter = true,
  view = {
    width = 35,
    side = "left",
    preserve_window_proportions = true,
  },
  filters = {
    git_ignored = false,
    dotfiles = true,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  modified = {
    enable = true,
  },

  -- For project.nvim
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
}
