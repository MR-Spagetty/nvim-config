local M = {}
local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
function M.caps(opts)
  return vim.tbl_deep_extend("keep", opts or {}, {
    capabilities = vim.tbl_deep_extend("keep", cmp_caps, {
      offsetEncoding = { "utf-16" },
      general = {
        positionEncodings = { "utf-16" },
      },
    }),
    offset_encoding = "utf-16",
  })
end

function M.default_attach()
  return function(client)
    vim.lsp.inlay_hint.enable()

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    if vim.documentHighlightprovider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        group = "lsp_document_highlight",
        buffer = 0,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end
end

return M
