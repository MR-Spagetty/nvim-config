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
