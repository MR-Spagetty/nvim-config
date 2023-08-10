local wk = require("which-key")
vim.g.mapleader = " "

-- TODO: Change the prefix = <leader> to the corresponding one. E.g. <leader>g
-- {{{ Nice terminal splitting: start_term(vsplit | split)
-- Settings are handled bu the autocmds
local function start_term(split_cmd)
  vim.cmd("botright " .. split_cmd .. " term://" .. vim.env.SHELL)
end
-- }}}

-- {{{ Terminal starting
wk.register({
  v = {
    v = { function() start_term("vsplit") end, "Vertical terminal" }
  },
  h = {
    h = { function() start_term("vsplit") end, "Horizontal terminal" }
  },
}, { prefix = '<leader>' })
-- }}}

-- {{{ Git
wk.register({
  g = {
    name = "Git",
    -- Open fugitive to the right
    g = { "<cmd>Git<cr><C-w>L", "Fugitive" },
    b = { "<cmd>Gitsigns blame_line<cr>", "Show blame" },
    s = { "<cmd>Telescope git_status<cr>", "Git status" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
    p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
  },
}, { prefix = '<leader>' })
-- }}}

-- {{{ Commenting
wk.register({
  ["/"] = { function() require("Comment.api").toggle.linewise.current() end, "Comment" }
}, { prefix = '<leader>' })

wk.register({
  ["/"] = { function()
    -- From the Comment.nvim documentation
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
  end, "Comment" }
}, { mode = { "v" }, prefix = '<leader>' })
-- }}}

-- {{{ Toggles
wk.register({
  name = "Toggles",
  s = { "<cmd>set spell!<cr>", "Toggle spellcheck" },
}, { prefix = '<leader>t' })
---}}}

-- {{{ TODO: Telescope
-- }}}

-- {{{ LSP
--  AutoCMD from lspconfig readme.md, hotkeys and such modified by me
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    wk.register({
      e = { vim.diagnostic.open_float, "Floating diagnostic" },
    }, { prefix = "<leader>" })

    wk.register({
      ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      ["[d"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
      K = { vim.lsp.buf.hover, "LSP Hover", opts },
    })

    wk.register({
      name = "LSP",
      q = { vim.diagnostic.setloclist, "Set location list" },
      a = { vim.lsp.buf.code_action, "Code action", opts },
      r = { "<cmd>Telescope lsp_references<cr>", "References", opts },
      w = {
        name = "Workspace folders",
        a = { vim.lsp.buf.add_workspace_folder, "Add folder", opts },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove folder", opts },
        l = { function()
          local str = ""
          for i, v in ipairs(vim.lsp.buf.list_workspace_folders()) do
            str = str .. i .. ". " .. v .. "\n"
          end
          print(str)
        end, "List folders", opts },
      },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", opts },
      S = { vim.lsp.buf.signature_help, "Signature help", opts },
      n = { vim.lsp.buf.rename, "Rename", opts },
      f = { function() vim.lsp.buf.format { async = true } end, "Format", opts },
      d = { vim.lsp.buf.definition, "Definition", opts },
      D = { vim.lsp.buf.declaration, "Declaration", opts },
      i = { vim.lsp.buf.implementation, "Implementation", opts },
      t = { vim.lsp.buf.type_definition, "Type definition", opts },
    }, { prefix = '<leader>l' })
  end,
})
-- }}}
