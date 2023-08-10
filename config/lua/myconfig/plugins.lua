-- Function to bind
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

  use("mbbill/undotree")

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("myconfig.config.indent-blankline")
    end,
  })

  -- Adds a toggle for transparent background, very nice :)
  use("xiyaowong/transparent.nvim")

  -- {{{ Themes
  -- {{{ Midnight
  --  Doesn't do transparent
  use ("dasupradyumna/midnight.nvim")
  -- }}}
  -- {{{ Rose-pine
  use ({
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup ({
        transparent = vim.g.transparent_enabled or false,
      })
    end,
  })
  -- }}}
  -- {{{ Kanagawa
  use ({
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup ({
        transparent = vim.g.transparent_enabled or false,
      })
    end,
  })
  -- }}}
  -- {{{ Nightfox
  use ({
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup ({
        transparent = vim.g.transparent_enabled or false,
      })
    end,
  })
  -- }}}
  -- }}}

  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = function()
      require("myconfig.config.telescope")
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  -- {{{ Completion
  use({
    "ms-jpq/coq_nvim",
    branch = "coq",
    config = function()
      require("myconfig.config.coq")
    end,
  })

  use({
    "ms-jpq/coq.artifacts",
    branch = "artifacts",
    requires = "coq_nvim",
  })
  -- }}}

  -- {{{ LSP
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  -- These should be configured in lsp.lua
  use({
    "williamboman/mason-lspconfig.nvim",
    requires = { "williamboman/mason.nvim" },
  })

  use("folke/neodev.nvim")

  use({
    "neovim/nvim-lspconfig",
    after = { "mason-lspconfig.nvim", "coq_nvim" },
    config = function()
      require("myconfig.config.lsp")
    end,
  })
  -- }}}

end)
