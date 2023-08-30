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
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- TODO: Check why it's not doing anything
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })
    end
  end
end

return M
