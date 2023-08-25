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
    getlint "cppcheck",
    getfmt "clang_format",
  },
  c = {
    getlint "cppcheck",
    getfmt "clang_format",
  },

  lua = {
    -- linter = getlint "luacheck", not sure how to configure it for nvim
    getfmt "stylua",
  },
  java = {
    getfmt "clang_format",
  },
  json = {
    getfmt "prettier",
  },
  javascript = {
    getfmt "prettier",
  },
  typescript = {
    getfmt "prettier",
  },
  markdown = {
    getfmt "prettier",
  },
  html = {
    getfmt "prettier",
  },
  rust = {
    getfmt "rustfmt",
  },
}

return caps {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/", ".rootmarker" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
