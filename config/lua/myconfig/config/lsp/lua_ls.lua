-- Get rid of that configure as luv message
-- From https://github.com/LunarVim/LunarVim/issues/4049#issuecomment-1634539474
local util = require "myconfig.config.lsp.util"
return util.caps {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
  on_attach = util.default_attach(),
}
