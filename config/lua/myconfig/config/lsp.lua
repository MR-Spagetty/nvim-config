local lspconfig = require "lspconfig"
local coq = require "coq"
local caps = coq.lsp_ensure_capabilities

local servers = {
  "lua_ls",
  "clangd",
  "jdtls",
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
  lspconfig[server].setup(caps {})
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
