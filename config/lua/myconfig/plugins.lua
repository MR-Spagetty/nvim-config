return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Neat very dark theme
  use {
    'dasupradyumna/midnight.nvim',
    -- Autoload
    config = function()
      vim.cmd.colorscheme "midnight"
    end,
  }
end)
