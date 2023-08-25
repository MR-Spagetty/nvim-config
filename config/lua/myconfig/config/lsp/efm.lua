-- Mostly taken from https://github.com/creativenull/efmls-configs-nvim
local caps = require "myconfig.config.lsp.util".caps
local function getlint(name)
  return require("efmls-configs.linters." .. name)
end
local function getfmt(name)
  return require("efmls-configs.formatters." .. name)
end
local languages = {
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
    formatter = getfmt "prettier",
  },
  javascript = {
    formatter = getfmt "prettier",
  },
  typescript = {
    formatter = getfmt "prettier",
  },
  html = {
    formatter = getfmt "prettier",
  },
}

return caps {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/', '.rootmarker' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

