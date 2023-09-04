-- Function to bind
return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- {{{ Tree sitter my beloved
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      -- Tiny setup, so it stays here.
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = { enable = true },
      }
    end,
  }
  -- }}}

  -- Adds a toggle for transparent background, very nice :)
  use "xiyaowong/transparent.nvim"

  -- {{{ Themes
  -- {{{ Midnight
  --  Doesn't do transparent
  use "dasupradyumna/midnight.nvim"
  -- }}}
  -- {{{ Rose-pine
  use {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup {
        transparent = vim.g.transparent_enabled or false,
      }
    end,
  }
  -- }}}
  -- {{{ Kanagawa
  use {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        transparent = vim.g.transparent_enabled or false,
      }
    end,
  }
  -- }}}
  -- {{{ Nightfox
  use {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup {
        transparent = vim.g.transparent_enabled or false,
      }
    end,
  }
  -- }}}
  -- {{{ Catppuccin
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup {
        transparent_background = vim.g.transparent_enabled or false,
      }
    end,
  }
  -- }}}
  -- }}}

  -- {{{ Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    config = function()
      require "myconfig.config.telescope"
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Emojis, kaomoji, unicode and latex math
  use {
    "nvim-telescope/telescope-symbols.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }

  -- Projects!!
  --[[{{{ project.nvim use {
    "ahmedkhalf/project.nvim",
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require("project_nvim").setup {}
      require('telescope').load_extension('projects')
    end
  } }}}]]

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }

  use {
    "nvim-telescope/telescope-project.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }

  -- Use telescope instead of nvim's default.
  use {
    "nvim-telescope/telescope-ui-select.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }

  -- Show images and other media files! Only ascii tho :(
  use {
    "nvim-telescope/telescope-media-files.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }
  -- }}}

  -- {{{ Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      {
        "saadparwaiz1/cmp_luasnip",
        requires = {
          "L3MON4D3/LuaSnip",
          requires = { "rafamadriz/friendly-snippets" },
          config = function()
            require "myconfig.config.luasnip"
          end,
        },
      },
    },
    config = function()
      require "myconfig.config.cmp"
    end,
  }
  -- }}}

  -- {{{ LSP
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  }

  -- These should be configured in lsp.lua
  use {
    "williamboman/mason-lspconfig.nvim",
    requires = { "williamboman/mason.nvim" },
  }

  use "folke/neodev.nvim"

  use {
    "neovim/nvim-lspconfig",
    after = { "mason-lspconfig.nvim" },
    config = function()
      require "myconfig.config.lsp"
    end,
  }
  -- }}}

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        triggers_nowait = { "z=" },
      }
    end,
  }

  use "mbbill/undotree"

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "myconfig.config.indent-blankline"
    end,
  }

  use {
    "creativenull/efmls-configs-nvim",
    requires = { "neovim/nvim-lspconfig" },
  }

  use {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup {}
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()

      local ft = require "Comment.ft"
      ft.processing = { "// %s", "/* %s */" }
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        -- The background of the signs isn't transparent,
        -- but having both of these makes it look better.
        signcolumn = true,
        numhl = true,
        current_line_blame = true,
      }
    end,
  }

  -- Delete buffers without messing things up
  use "famiu/bufdelete.nvim"

  use {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "myconfig.config.nvim-tree"
    end,
  }

  -- Yes!!
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        fast_wrap = {},
      }
    end,
  }

  -- Highlight lines in cursor jump
  use {
    "rainbowhxch/beacon.nvim",
    config = function()
      require("beacon").setup {
        timeout = 800,
      }
    end,
  }

  -- Quite neat.
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        "*",
        highlight = {
          keyword = "fg",
        },
      }
    end,
  }

  -- TODO comments! My beloved!
  use {
    "folke/todo-comments.nvim",
    requires = {
      "nvim-lua/plenary.nvim", --[["folke/trouble.nvim"]]
    },
    config = function()
      require("todo-comments").setup {
        highlight = {
          keyword = "fg",
        },
      }
    end,
  }

  use {
    "mfussenegger/nvim-dap",
    config = function()
      require "myconfig.config.dap"
    end,
  }

  use {
    "mxsdev/nvim-dap-vscode-js",
    requires = {
      { "mfussenegger/nvim-dap" },
      {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv -f dist out",
      },
    },
  }

  use {
    "theHamsta/nvim-dap-virtual-text",
    require = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-dap-virtual-text").setup {}
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { { "nvim-tree/nvim-web-devicons", opt = true }, "dokwork/lualine-ex" },
    config = function()
      require "myconfig.config.lualine"
    end,
  }

  use {
    "m4xshen/hardtime.nvim",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("hardtime").setup {
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "fugitive" },
        restricted_keys = {
          ["h"] = {},
          ["j"] = {},
          ["k"] = {},
          ["l"] = {},
        },
        disabled_keys = {
          ["<Up>"] = { "n" },
          ["<Down>"] = { "n" },
          ["<Left>"] = { "n" },
          ["<Right>"] = { "n" },
        },
      }
    end,
  }
  use "AndrewRadev/bufferize.vim"
  use "chrisbra/csv.vim"
  use "dpezto/gnuplot.vim"
  use "sophacles/vim-processing"
  use "mfussenegger/nvim-jdtls"
  use "eandrju/cellular-automaton.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "tpope/vim-surround"
  use "tpope/vim-fugitive"

  -- {{{ Commented out
  -- Blazingly fast, doesn't work. Sends me to the wrong file.
  -- use({"ThePrimeagen/harpoon", requires = { 'nvim-lua/plenary.nvim' }})

  --[[ Very cool plugin, maybe when there's sixel support.
  use {
    "3rd/image.nvim",
    rocks = { 'magick' },
  }
  ]]
  -- }}}
end)
