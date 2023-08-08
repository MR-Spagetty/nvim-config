local lspconfig = require("lspconfig")

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
  lspconfig[server].setup {}
end

-- {{{ lua_ls
-- Get rid of that configure as luv message
-- From https://github.com/LunarVim/LunarVim/issues/4049#issuecomment-1634539474
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
-- }}}
