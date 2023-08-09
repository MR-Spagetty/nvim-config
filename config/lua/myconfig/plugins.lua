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

  -- {{{ Themes
  -- {{{ Theme wrapper function
  -- This function sets up transparent with transparent_enabled
  local function usetranstheme(theme, module)
    use {
      theme,
      after = {"xiyaowong/transparent.nvim" },
      config = function()
        module.setup ({
          transparent = vim.g.transparent_enabled,
        })
      end
    }
  end
  --- }}}

  usetranstheme("dasupradyumna/midnight.nvim", require("midnight"))
  usetranstheme("rose-pine/neovim", require("rose-pine"))
  usetranstheme("rebelot/kanagawa.nvim", require("kanagawa"))
  usetranstheme("EdenEast/nightfox.nvim", require("nightfox"))
  -- }}}

  -- Adds a toggle for transparent background, very nice :)
  use {
    "xiyaowong/transparent.nvim"
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = function()
      require("myconfig.config.telescope")
    end,
    requires = { {'nvim-lua/plenary.nvim'} }
  }

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
