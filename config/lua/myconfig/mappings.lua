local wk = require "which-key"
vim.g.mapleader = " "

-- {{{ Non WhichKey
-- Disable highlighting
vim.keymap.set("n", "<Esc>", "<Esc>:noh<cr>", { silent = true })
-- }}}

-- NOTE: Harpoon is broken, binds commented out
-- TODO: Change the prefix = <leader> to the corresponding one. E.g. <leader>g
-- {{{ Nice terminal splitting: start_term(vsplit | split)
local function start_term(split_cmd)
  vim.cmd("botright " .. split_cmd .. " term://" .. vim.env.SHELL)
  -- Kill as soon as it's out of sight
  vim.bo.bufhidden = "wipe"

  vim.api.nvim_create_autocmd({ "TermClose" }, {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function(args)
      -- If it is in fact hidden, then the previous option should handle it
      -- Thanks to https://old.reddit.com/r/neovim/comments/q5z38t/easiest_way_to_find_if_a_buffer_is_hidden/hggptam/
      if vim.fn.getbufinfo(args.buf)[1].hidden == 0 then
        vim.cmd "bwipeout"
      end
    end,
  })
end
-- }}}

-- {{{ Terminal starting
wk.register({
  v = {
    v = {
      function()
        start_term "vsplit"
      end,
      "Vertical terminal",
    },
  },
  h = {
    h = {
      function()
        start_term "split"
      end,
      "Horizontal terminal",
    },
  },
}, { prefix = "<leader>" })
-- }}}

-- {{{ Git
wk.register({
  name = "Git",
  -- Open fugitive to the right
  g = { "<cmd>vertical Git<cr>", "Fugitive" },
  b = { "<cmd>Gitsigns blame_line<cr>", "Show blame" },
  d = { "<cmd>Telescope git_status<cr>", "Git diffs" },
  n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
  p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
}, { prefix = "<leader>g" })
-- }}}

-- {{{ Commenting
wk.register({
  ["/"] = {
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    "Comment",
  },
}, { prefix = "<leader>" })

wk.register({
  ["/"] = {
    function()
      -- From the Comment.nvim documentation
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end,
    "Comment",
  },
}, { mode = { "v" }, prefix = "<leader>" })
-- }}}

-- {{{ Toggles
wk.register({
  name = "Toggles",
  s = { "<cmd>set spell!<cr>", "Toggle spellcheck" },
}, { prefix = "<leader>t" })
---}}}

-- {{{ Telescope
local tele = require "telescope"
local telebuilt = require "telescope.builtin"
wk.register({
  name = "Telescope",
  f = { telebuilt.find_files, "Find files" },
  -- h = { "<cmd>Telescope harpoon marks<cr>", "Harpoon marks" },
  g = { telebuilt.live_grep, "Live grep" },
  a = { telebuilt.builtin, "Telescope builtins" },
  t = { telebuilt.treesitter, "Treesitter symbols" },
  q = { telebuilt.quickfix, "Quickfix" },
  l = { telebuilt.loclist, "Location list" },
  p = { telebuilt.oldfiles, "Previous files" },
  b = { telebuilt.buffers, "Open buffers" },
  j = { telebuilt.jumplist, "Jump list" },
  h = { telebuilt.help_tags, "Help tags" },
  m = { telebuilt.man_pages, "Man pages" },
  o = {
    function()
      tele.extensions.project.project { display_type = "full" }
    end,
    "Search projects",
  },
  d = { vim.cmd.TodoTelescope, "Find TODOs" },
  ["/"] = { telebuilt.current_buffer_fuzzy_find, "Fuzzy find" },
}, { prefix = "<leader>f" })
-- }}}

--[[ -- {{{ Harpoon
wk.register({
  name = "Harpoon",
  a = { require("harpoon.mark").add_file, "Add file" },
  m = { require("harpoon.ui").toggle_quick_menu, "Toggle menu" },
  n = { require("harpoon.ui").nav_next(), "Next file" },
  p = { require("harpoon.ui").nav_prev(), "Prev file" },
}, { prefix = "<leader>h" })
-- }}} ]]

-- {{{ DAP
-- Check :help dap-api
wk.register({
  name = "Debugging",
  b = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
  B = {
    function()
      require("dap").list_breakpoints(true)
    end,
    "List breakpoints",
  },
  e = { require("dap").set_exception_breakpoints, "Set exception breakpoints" },
  D = { require("dap").clear_breakpoints, "Clear breakpoints" },
  c = { require("dap").continue, "Continue" },
  s = { require("dap").step_over, "Step" },
  i = { require("dap").step_into, "Step in" },
  o = { require("dap").step_out, "Step out" },
  r = { require("dap").repl.toggle, "Toggle REPL" },
  h = { require("dap").run_to_cursor, "Run to cursor" },
  ["<Up>"] = { require("dap").up, "Stacktrace up" },
  ["<Down>"] = { require("dap").down, "Stacktrace down" },
  k = {
    function()
      require("dap").disconnect()
      require("dap").close()
    end,
    "Stop debugging",
  },
}, { prefix = "<leader>d" })
-- }}}

-- {{{ LSP
--  AutoCMD from lspconfig readme.md, hotkeys and such modified by me
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    wk.register({
      q = { vim.diagnostic.open_float, "Floating diagnostic" },
    }, { prefix = "<leader>" })

    wk.register {
      ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      ["[d"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
      K = { vim.lsp.buf.hover, "LSP Hover", opts },
    }

    wk.register({
      name = "LSP",
      q = { vim.diagnostic.setloclist, "Set location list" },
      a = { vim.lsp.buf.code_action, "Code action", opts },
      r = { "<cmd>Telescope lsp_references<cr>", "References", opts },
      w = {
        name = "Workspace folders",
        a = { vim.lsp.buf.add_workspace_folder, "Add folder", opts },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove folder", opts },
        l = {
          function()
            local str = ""
            for i, v in ipairs(vim.lsp.buf.list_workspace_folders()) do
              str = str .. i .. ". " .. v .. "\n"
            end
            print(str)
          end,
          "List folders",
          opts,
        },
      },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", opts },
      S = { vim.lsp.buf.signature_help, "Signature help", opts },
      n = { vim.lsp.buf.rename, "Rename", opts },
      f = {
        function()
          vim.lsp.buf.format { async = true }
        end,
        "Format",
        opts,
      },
      d = { vim.lsp.buf.definition, "Definition", opts },
      D = { vim.lsp.buf.declaration, "Declaration", opts },
      i = { vim.lsp.buf.implementation, "Implementation", opts },
      t = { vim.lsp.buf.type_definition, "Type definition", opts },
      v = { require("telescope.builtin").diagnostics, "Diagnostics" },
    }, { prefix = "<leader>l" })
  end,
})
-- }}}

-- {{{ Easy window movement with ctrl arrow
wk.register({
  ["<C-Up>"] = { "<C-w>k", "Go to the up window" },
  ["<C-Down>"] = { "<C-w>j", "Go to the down window" },
  ["<C-Left>"] = { "<C-w>h", "Go to the left window" },
  ["<C-Right>"] = { "<C-w>l", "Go to the right window" },
}, {})
-- }}}

-- {{{ Text moving
wk.register({
  ["<M-Down>"] = { ":move '>+1<cr>gv=gv", "Move lines down" },
  ["<M-Up>"] = { ":move '<-2<cr>gv=gv", "Move lines up" },
  ["<M-k>"] = { ":move '<-2<cr>gv=gv", "which_key_ignore" },
  ["<M-j>"] = { ":move '>+1<cr>gv=gv", "which_key_ignore" },
}, { mode = "v" })
-- }}}

-- {{{ Loose mappings
wk.register({
  x = { "<cmd>Bdelete<cr>", "Delete buffer" },
  e = {
    function()
      -- Toggle or focus depending on if we're on it
      local tree = require("nvim-tree.api").tree
      if tree.is_tree_buf() then
        tree.close_in_this_tab()
      else
        tree.focus()
      end
    end,
    "Toggle Nvim tree",
  },
}, { prefix = "<leader>" })

wk.register({
  w = { "<cmd>WhichKey<cr>", "Open WhichKey" },
}, { mode = { "n", "v" }, prefix = "<leader>" })

-- }}}
