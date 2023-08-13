local telescope = require("telescope")
require('telescope').load_extension('project')
require('telescope').load_extension('media_files')
-- telescope.load_extension('harpoon')

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}

