return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Tree sitter my beloved
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      -- Tiny setup, so it stays here.
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  })

  -- Neat very dark theme
  use({
    "dasupradyumna/midnight.nvim",
    -- Autoload
    config = function()
      vim.cmd.colorscheme("midnight")
    end,
  })

  -- LSPs
  -- These need to be set up first,
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  -- Should be set up in lsp.lua
  use({
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  })

  -- Then this
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("myconfig.config.lsp")
    end,
  })
end)
