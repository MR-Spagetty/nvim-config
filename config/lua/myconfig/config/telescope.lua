local telescope = require("telescope")

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    },
    project = {
      base_dirs = {
        {'~/projects', max_depth = 4},
      },
      order_by = "recent"
    }
  }
}

telescope.load_extension('project')
telescope.load_extension('media_files')
telescope.load_extension('file_browser')
-- telescope.load_extension('harpoon')
