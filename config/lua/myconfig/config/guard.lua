local ft = require("guard.filetype")
-- ft('lang'):fmt('format-tool-1')
--        :append('format-tool-2')
--        :lint('lint-tool-1')
--        :append('lint-tool-2')

ft("c,cpp,java,json"):fmt({ cmd = 'clang-format', find = '.clang-format'})
ft("cpp"):lint("clang-tidy")
ft("lua"):fmt("stylua")

require("guard").setup({
  fmt_on_save = false,
  lsp_as_default_formatter = true,
})
