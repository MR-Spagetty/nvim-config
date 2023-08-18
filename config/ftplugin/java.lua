-- Template from https://github.com/mfussenegger/nvim-jdtls
local caps = require("coq").lsp_ensure_capabilities

local config = {
  cmd = { "/usr/bin/jdtls" },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  settings = {
    java = caps {
      server_capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
      },
      {
        signatureHelp = {
          enabled = true,
        },
        contentProvider = {
          preferred = "fernflower",
        },
      },
    },
  },
}

require("jdtls").start_or_attach(config)
