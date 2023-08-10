-- Function to bind
return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- {{{ Tree sitter my beloved
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
  -- }}}

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
  -- {{{ Catppuccin
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = vim.g.transparent_enabled or false,
      })
    end
  })
  -- }}}
  -- }}}

-- {{{ Telescope
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = function()
      require("myconfig.config.telescope")
    end,
    requires = { 'nvim-lua/plenary.nvim' }
  })

  use({
    'nvim-telescope/telescope-symbols.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  })
-- }}}

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

  use({
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        triggers_nowait = { "z=" },
      }
    end
  })

  use("mbbill/undotree")

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("myconfig.config.indent-blankline")
    end,
  })

  use({
    "ethanholz/nvim-lastplace",
    config = function ()
      require("nvim-lastplace").setup({})
    end
  })

  use({
   "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        -- The background of the signs isn't transparent,
        -- but having both of these makes it look better.
        signcolumn = true,
        numhl = true,
        current_line_blame = true,
      })
    end,
  })

  -- Delete buffers without messing things up
  use("famiu/bufdelete.nvim")

  -- Blazingly fast
  use({"ThePrimeagen/harpoon", requires = { 'nvim-lua/plenary.nvim' }})

  use("tpope/vim-surround")
  use("tpope/vim-fugitive")
end)
