local ft = require "guard.filetype"
-- ft('lang'):fmt('format-tool-1')
--        :append('format-tool-2')
--        :lint('lint-tool-1')
--        :append('lint-tool-2')

-- {{{ My custom fmt definitions
local fmts = {
  -- If I don't tell it to find the file it doesn't follow it
  ["clang-format"] = { cmd = "clang-format", find = ".clang-format", stdin = true },
}
-- }}}

ft("c,cpp,java,json"):fmt(fmts["clang-format"])
ft("cpp"):lint "clang-tidy"
ft("lua"):fmt "stylua"

require("guard").setup {
  fmt_on_save = false,
  lsp_as_default_formatter = true,
}
