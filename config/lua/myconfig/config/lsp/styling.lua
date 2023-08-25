-- {{{ Make the pop ups have pretty borders :)
-- Take a look at https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- My thanks to https://old.reddit.com/r/neovim/comments/wscfar/how_to_get_bordered_ui_for_hover_actions_in/ikxnw81/
-- Border format adapted from the wiki page
local border = {
  { "╓", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╙", "FloatBorder" },
  { "║", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config {
  float = {
    border = border,
  },
  -- update_in_insert = true,
  virtual_text = {
    prefix = " ",
  },
}
-- }}}

-- {{{ Style diagnostics.
-- 
local signs = { Error = "󰈸", Warn = "", Hint = "󱝁", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

-- {{{ Highlight references on hold
-- Taken from the lspconfig wiki, edited to be an underline instead of highlight
-- TODO: Add a toggle? Could be done with the autogroup.
vim.cmd [[
    hi! LspReferenceRead  cterm=bold ctermbg=red gui='underline'
    hi! LspReferenceText  cterm=bold ctermbg=red gui='underline'
    hi! LspReferenceWrite cterm=bold ctermbg=red gui='underline'
  ]]
vim.api.nvim_create_augroup("lsp_document_highlight", {
  clear = false,
})
vim.api.nvim_clear_autocmds {
  buffer = 0,
  group = "lsp_document_highlight",
}
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = "lsp_document_highlight",
  buffer = 0,
  callback = vim.lsp.buf.clear_references,
})
-- }}}
