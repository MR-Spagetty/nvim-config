local lspconfig = require "lspconfig"
local util = require "myconfig.config.lsp.util"

local servers = {
  "lua_ls",
  "clangd",
  "pyright",
  "tsserver",
  "cssls",
  "jsonls",
  "rust_analyzer",
  "marksman",
  "bashls",
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
  lspconfig[server].setup(util.caps {
    -- Disable formatting. efm should handle that.
    on_attach = util.default_attach(),
  })
end

lspconfig.lua_ls.setup(require "myconfig.config.lsp.lua_ls")
lspconfig.efm.setup(require "myconfig.config.lsp.efm")

-- TODO: Move to custom file

require "myconfig.config.lsp.styling"
