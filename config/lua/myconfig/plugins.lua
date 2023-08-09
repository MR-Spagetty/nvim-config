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

  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  -- {{{ Completion
  use({
    "ms-jpq/coq_nvim",
    branch = "coq",
    config = function()
      require("myconfig.config.coq")
    end,
    run = function()
      -- Kinda needs this
      vim.cmd.COQdeps()
    end,
  })

  use({
    "ms-jpq/coq.artifacts",
    branch = "artifacts",
    requires = "coq_nvim",
  })
  -- }}}

  -- {{{ LSP
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
