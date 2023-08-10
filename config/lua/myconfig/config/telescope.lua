local telescope = require("telescope")

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}

-- Get harpooning
telescope.load_extension('harpoon')
