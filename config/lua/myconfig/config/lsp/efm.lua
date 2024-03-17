-- Mostly taken from https://github.com/creativenull/efmls-configs-nvim
local caps = require("myconfig.config.lsp.util").caps

local function getlint(name)
  return require("efmls-configs.linters." .. name)
end

local function getfmt(name)
  return require("efmls-configs.formatters." .. name)
end

local languages = {
  cpp = {
    getlint("cppcheck"),
    require("myconfig.config.lsp.clang_format"),
  },
  c = {
    getlint("cppcheck"),
    require("myconfig.config.lsp.clang_format"),
  },

  lua = {
    -- linter = getlint "luacheck", not sure how to configure it for nvim
    getfmt("stylua"),
  },
  java = {
    require("myconfig.config.lsp.clang_format"),
  },
  jsonc = {
    getfmt("prettier"),
  },
  json = {
    getfmt("prettier"),
  },
  javascript = {
    getfmt("prettier"),
  },
  typescript = {
    getlint("eslint_d"),
    getfmt("prettier"),
  },
  markdown = {
    getfmt("prettier"),
  },
  html = {
    getfmt("prettier"),
  },
  rust = {
    getfmt("rustfmt"),
  },
  sh = {
    getfmt("shfmt"),
  },
  bash = {
    getfmt("shfmt"),
  },
  python = {
    getlint("flake8"),
    getfmt("autopep8"),
  },
}

return caps({
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/", ".rootmarker" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
})

