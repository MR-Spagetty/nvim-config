-- Bootstrap lazy.nvim (from the README)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Actual plugins:
local plugins = {

  { "akinsho/git-conflict.nvim", lazy = false, version = "*", config = true },
  -- Tree sitter my beloved
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("myconfig.config.treesitter")
    end,
  },

  { "xiyaowong/transparent.nvim", lazy = false },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = function()
      return {
        transparent = vim.g.transparent_enabled or false,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = function()
      return {
        style = "night",
        transparent = vim.g.transparent_enabled or false,
        on_highlights = function(highlights, colors)
          highlights.CursorLineNr = {
            fg = colors.orange,
          }

          colors.comment = "#7D84A4"
          highlights.Comment.fg = "#7D84A4"
          highlights.CmpItemAbbr.fg = colors.dark3
          highlights.CmpItemAbbrMatch.fg = colors.fg_dark
          highlights.CmpItemKindVariable.fg = colors.orange
        end,
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = function()
      return {
        transparent = vim.g.transparent_enabled or false,
      }
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = function()
      return {
        transparent_background = vim.g.transparent_enabled or false,
        color_overrides = {
          mocha = {
            base = "#110f0b",
          },
        },
        custom_highlights = function(colors)
          return {
            LspInlayHint = { bg = colors.none },
          }
        end,
      }
    end,
  },

  {
    "Everblush/nvim",
    name = "everblush",
    opts = function()
      return {
        transparent_background = vim.g.transparent_enabled or false,
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    version="*",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { "<leader>f", "<leader>l" },
    config = function()
      require("myconfig.config.telescope")
    end,
  },

  -- Emojis, kaomoji, unicode and latex math
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local cmd = vim.api.nvim_create_user_command

      cmd("Kaomoji", function()
        require("telescope.builtin").symbols({ sources = { "kaomoji" } })
      end, {})
      cmd("Emoji", function()
        require("telescope.builtin").symbols({ sources = { "emoji" } })
      end, {})
      cmd("MathUnicode", function()
        require("telescope.builtin").symbols({ sources = { "math" } })
      end, {})
      cmd("MathLatex", function()
        require("telescope.builtin").symbols({ sources = { "latex" } })
      end, {})

      cmd("Nerd", function()
        require("telescope.builtin").symbols({ sources = { "nerd" } })
      end, {})
    end,
    cmd = { "Emoji", "MathLatex", "MathUnicode", "Kaomoji", "Nerd" },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
  },

  {
    "LintaoAmons/cd-project.nvim",
    opts = require("myconfig.config.cdproject"),
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  -- Use telescope instead of nvim's default.
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-telescope/telescope-file-browser.nvim" },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
            version = "v2.*",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
    },
    config = function()
      require("myconfig.config.cmp")
    end,
    event = "InsertEnter",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    -- TODO: Steal LazyFile from lazyvim
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      require("myconfig.config.lsp")
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        delay = 0,
      })
    end,
  },

  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "farmergreg/vim-lastplace",
    lazy = false,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      local ft = require("Comment.ft")
      ft.processing = { "// %s", "/* %s */" }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    commit = "7e38f07",
    opts = {
      -- The background of the signs isn't transparent,
      -- but having both of these makes it look better.
      signcolumn = true,
      numhl = true,
      current_line_blame = true,
    },
  },

  -- Delete buffers without messing things up
  { "famiu/bufdelete.nvim", cmd = "Bdelete" },

  {
    "stevearc/oil.nvim",
    opts = {},
    cmd = "Oil",
  },

  -- Yes!!
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
    },
    event = "InsertEnter",
  },

  -- Highlight lines in cursor jump
  {
    "rainbowhxch/beacon.nvim",
    opts = {
      timeout = 800,
    },
    enabled = false,
  },

  -- Quite neat.
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        mode = "background",
        virtualtext = "██",
      },
    },
    commit = "85855b3",

    config = function(_, opts)
      -- GRRRRRRRRRRRRRRRRRRRRRRR
      if not vim.opt.termguicolors then
        return
      end

      local c = require("colorizer")
      c.setup(opts)

      -- The following snippet is from gregorias.
      -- https://github.com/NvChad/nvim-colorizer.lua/issues/57#issue-1650919460
      -- nvim-colorizer doesn't work on the initial buffer if we lazy load, so force it to attach
      -- on load.
      local bufnr = vim.api.nvim_get_current_buf()
      if bufnr and not c.is_buffer_attached(bufnr) then
        c.attach_to_buffer(bufnr)
      end
    end,
    event = { "VeryLazy" },
  },

  -- TODO comments! My beloved!
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      highlight = {
        keyword = "fg",
      },
    },
    event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "microsoft/java-debug",
        build = "./mvnw clean install",
      },

      {
        "rcarriga/nvim-dap-ui",
        opts = {},
        dependencies = { "nvim-neotest/nvim-nio" },
      },

      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
      },
    },
    keys = { "<leader>d" },
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "dokwork/lualine-ex" },
    config = function()
      require("myconfig.config.lualine")
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").add_default_mappings()
    end,
    event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-jdtls",
  },

  {
    "tpope/vim-surround",
    -- Makes . repeats work
    dependencies = { "tpope/vim-repeat" },
    event = "VeryLazy",
  },

  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "akinsho/org-bullets.nvim", opts = {} },
    },
    opts = {},
    ft = "org",
  },

  {
    "turbio/bracey.vim",
    build = "npm install --prefix server",
    enabled = false,
  },

  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
  },

  {
    "sophacles/vim-processing",
    config = function()
      -- The processing extension adds this highlight but it conflicts with my todo extension and makes stuff unreadable
      vim.cmd([[hi Todo guibg=None guifg=None]])
    end,
    event = "VeryLazy",
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "rcasia/neotest-java", commit = "3a1853d55789b03ef71e1748a69470a0d016afad" },
      "nvim-neotest/nvim-nio",
    },

    config = function()
      require("myconfig.config.neotest")
    end,

    keys = "<leader>r",
  },

  {
    "dsych/blanket.nvim",
    -- TODO: Tryan gasod  as h ha she ah
    opts = {
      report_path = vim.fn.getcwd() .. "/build/reports/jacoco/test/jacocoTestReport.xml",
      -- refresh gutter every time we enter java file
      filetypes = "java",
      silent = true,
      -- can set the signs as well
      signs = {
        priority = 6,
        incomplete_branch = "?",
        uncovered = "x",
        covered = "c",
        sign_group = "Blanket",

        -- and the highlights for each sign!
        -- useful for themes where below highlights are similar
        incomplete_branch_color = "WarningMsg",
        covered_color = "String",
        uncovered_color = "Error",
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "*",
    init = function()
      ---@type RustaceanOpts
      vim.g.rustaceanvim = {
        tools = {
          code_actions = {
            -- This is part of my patch, hopefully the PR gets merged.
            group_icon = " ›",
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- This is a little evil but ngl i can't be bothered to think of
            -- a better way to override the default binds
            local timer = vim.uv.new_timer()
            timer:start(
              100,
              0,
              vim.schedule_wrap(function()
                timer:stop()
                timer:close()

                local wk = require("which-key")
                wk.register({
                  a = {
                    function()
                      vim.cmd.RustLsp("codeAction")
                    end,
                    "Code Action",
                  },
                }, { mode = { "n", "v" }, prefix = "<leader>l", buffer = bufnr })

                -- RustLsp only
                wk.register({
                  name = "RustLsp",
                  d = {
                    function()
                      vim.cmd.RustLsp("debuggables")
                    end,
                    "Debuggables",
                  },
                  e = {
                    function()
                      vim.cmd.RustLsp("explainError")
                    end,
                    "Explain error",
                  },
                  j = {
                    function()
                      vim.cmd.RustLsp("joinLines")
                    end,
                    "Join lines",
                  },
                  m = {
                    function()
                      vim.cmd.RustLsp("expandMacro")
                    end,
                    "Expand macro",
                  },
                  r = {
                    function()
                      vim.cmd.RustLsp("runnables")
                    end,
                    "Runnables",
                  },
                  s = {
                    function()
                      vim.cmd.RustLsp("renderDiagnostic")
                    end,
                    "Render diagnostic",
                  },
                }, { mode = { "n", "v" }, prefix = "<leader>ll", buffer = bufnr })

                -- Hover depending on mode
                wk.register({
                  K = {
                    function()
                      vim.cmd.RustLsp({ "hover", "actions" })
                    end,
                    "LSP Hover",
                  },
                }, { mode = { "n" }, buffer = bufnr })

                wk.register({
                  K = {
                    function()
                      vim.cmd.RustLsp({ "hover", "range" })
                    end,
                    "LSP Hover",
                  },
                }, { mode = { "v" }, buffer = bufnr })
              end)
            )
          end,
        },
      }
    end,
    ft = { "rust" },
  },

  { "tpope/vim-fugitive", cmd = "Git" },
  { "danymat/neogen", opts = {}, keys = "<leader>lg" },
  { "mbbill/undotree", event = "VeryLazy" },
  { "chrisbra/csv.vim", ft = "csv" },
  { "dpezto/gnuplot.vim", event = "VeryLazy" },
  { "elixir-editors/vim-elixir", event = "VeryLazy" },
  { "Hoffs/omnisharp-extended-lsp.nvim", ft = "cs" },
  { "AndrewRadev/bufferize.vim", cmd = "Bufferize" },
  { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    'sophieforrest/processing.nvim',
    -- This plugin is already lazy-loaded.
    lazy = false,
    -- Recommended.
    version = "^1",
  },
}

require("lazy").setup(plugins, {
  -- How far can we get with this
  defaults = {
    lazy = true,
  },
  change_detection = {
    enabled = false,
  },
})
