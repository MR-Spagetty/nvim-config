-- Adapted from https://github.com/hrsh7th/nvim-cmp
local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

-- {{{ Has words before, for super tab
local has_words_before = function()
  local unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
-- }}}

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false },

    -- {{{ Super tab completion
    -- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
    -- Either indents, goes through completion options, or goes through snippet fields.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- }}}
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
  view = {
    -- Flip order when cursor is low.
    entries = { name = "custom", selection_order = "near_cursor" },
  },
  -- Pretty symbols
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      },
    },
  },
  -- Virtual text
  experimental = {
    ghost_text = true,
  },
}

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
