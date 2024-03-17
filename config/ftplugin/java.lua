-- Template from https://github.com/mfussenegger/nvim-jdtls
-- local caps = require("coq").lsp_ensure_capabilities

local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
local function caps(opts)
  return vim.tbl_deep_extend("keep", opts or {}, { capabilities = cmp_caps })
end

local function on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local root_dir = vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]

-- Start the basic one when without a root dir.
-- nvim-jdtls starts scanning the whole folder or something. This is usually my
-- home folderwhich slows everything down and spins up my CPU to 100%
if root_dir == nil then
  require("lspconfig").jdtls.setup(caps { on_attach = on_attach })
  -- This is kinda cursed but lspconfig setups an autocommand,
  -- so it needs to be triggered again.
  -- The global stops infinite recursion.
  if not vim.g.jdtls_reedit_single_file then
    vim.notify "No root dir. RIP."
    vim.g.jdtls_reedit_single_file = 1
    vim.cmd [[edit!]]
  else
    vim.g.jdtls_reedit_single_file = nil
  end
  return
end

-- NOTE: Install openjdk-src to get good docs when hovering
local config = {
  cmd = { "jdtls" },
  root_dir = vim.fs.dirname(root_dir),
  on_attach = on_attach,
  settings = caps {
    java = {
      signatureHelp = {
        enabled = true,
      },
      contentProvider = {
        preferred = "fernflower",
      },
    },
  },
}

require("jdtls").start_or_attach(config)

-- {{{ Reference highlight
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
