local lspconfig = require "lspconfig"
local coq = require "coq"
local caps = coq.lsp_ensure_capabilities

-- TODO: Move to lsp/init.lua, create .lua files for servers needing more config.
local servers = {
  "lua_ls",
  "clangd",
  "pyright",
}

-- {{{ Mason
-- Ensure these are setup before doing other stuff
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = servers,
}
--- }}}

-- Get neat stuff for nvim config
require("neodev").setup()

-- Do a default setup for all the stuff
for _, server in ipairs(servers) do
  lspconfig[server].setup(caps {
    -- Disable formatting. efm should handle that.
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
end

-- {{{ lua_ls
-- Get rid of that configure as luv message
-- From https://github.com/LunarVim/LunarVim/issues/4049#issuecomment-1634539474
lspconfig.lua_ls.setup(caps {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
})
-- }}}

-- {{{ Efm languager server(s)
-- Mostly taken from https://github.com/creativenull/efmls-configs-nvim
local efmls = require "efmls-configs"
local on_attach = nil
efmls.init {
  -- Your custom attach function
  on_attach = on_attach,

  -- Enable formatting provided by efm langserver
  init_options = {
    documentFormatting = true,
  },
}

local function getlint(name)
  return require("efmls-configs.linters." .. name)
end
local function getfmt(name)
  return require("efmls-configs.formatters." .. name)
end
efmls.setup {
  cpp = {
    linter = getlint "cppcheck",
    formatter = getfmt "clang_format",
  },
  c = {
    linter = getlint "cppcheck",
    formatter = getfmt "clang_format",
  },

  lua = {
    -- linter = getlint "luacheck", not sure how to configure it for nvim
    formatter = getfmt "stylua",
  },
  java = {
    formatter = getfmt "clang_format",
  },
  json = {
    formatter = getfmt "clang_format",
  },
}
-- }}}

-- TODO: Move to custom file

-- {{{ Yassification
-- {{{ Make the pop ups have pretty borders :)
-- Take a look at https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- My thanks to https://old.reddit.com/r/neovim/comments/wscfar/how_to_get_bordered_ui_for_hover_actions_in/ikxnw81/
-- Border format adapted from the wiki page
local border = {
  { "╓", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╙", "FloatBorder" },
  { "║", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config {
  float = {
    border = border,
  },
  update_in_insert = true,
  virtual_text = {
    prefix = " ",
  },
}
-- }}}

-- {{{ Style diagnostics.
-- 
local signs = { Error = "󰈸", Warn = "", Hint = "󱝁", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

-- {{{ Highlight references on hold
-- Taken from the lspconfig wiki, edited to be an underline instead of highlight
-- TODO: Add a toggle? Could be done with the autogroup.
vim.cmd [[
    hi! LspReferenceRead  cterm=bold ctermbg=red gui='underline'
    hi! LspReferenceText  cterm=bold ctermbg=red gui='underline'
    hi! LspReferenceWrite cterm=bold ctermbg=red gui='underline'
  ]]
vim.api.nvim_create_augroup("lsp_document_highlight", {
  clear = false,
})
vim.api.nvim_clear_autocmds {
  buffer = 0,
  group = "lsp_document_highlight",
}
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = "lsp_document_highlight",
  buffer = 0,
  callback = vim.lsp.buf.document_highlight,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = "lsp_document_highlight",
  buffer = 0,
  callback = vim.lsp.buf.clear_references,
})
-- }}}
-- }}}
