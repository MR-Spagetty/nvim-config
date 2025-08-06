local wk = require("which-key")
vim.g.mapleader = " "

-- {{{ Non WhichKey
-- Disable highlighting
vim.keymap.set("n", "<Esc>", "<Esc>:noh<cr>", { silent = true })
-- }}}

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
        vim.cmd("bwipeout")
      end
    end,
  })
end
-- }}}

-- {{{ Terminal starting
wk.add({
  {
    "<leader>vv",
    function()
      start_term("vsplit")
    end,
    desc = "Vertical terminal",
  },
  {
    "<leader>hh",
    function()
      start_term("split")
    end,
    desc = "Horizontal terminal",
  },
})
-- }}}

-- {{{ Git
wk.add({
  { "<leader>g", group = "Git" },
  -- Open fugitive to the right
  { "<leader>ga", "<cmd>vertical Git<cr>", desc = "Fugitive" },
  { "<leader>gb", "<cmd>Git add %<cr>", desc = "Add buffer" },
  { "<leader>gc", "<cmd>vertical Git commit -v<cr>", desc = "Commit" },
  { "<leader>gd", "<cmd>Gitsigns blame_line<cr>", desc = "Show blame" },
  { "<leader>gg", "<cmd>Telescope git_status<cr>", desc = "Git diffs" },
  { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
  { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
})
-- }}}

-- {{{ Commenting
wk.add({
  {
    "<leader>/",
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    desc = "Comment",
  },
})

wk.add({
  {
    "<leader>/",
    function()
      -- From the Comment.nvim documentation
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end,
    desc = "Comment",
    mode = "v",
  },
})
-- }}}

-- {{{ Toggles
wk.add({
  { "<leader>t", group = "Toggles" },
  { "<leader>ts", "<cmd>set spell!<cr>", desc = "Toggle spellcheck" },
})
-- }}}

-- {{{ Telescope
local tele = require("telescope")
local telebuilt = require("telescope.builtin")
wk.add({
  { "<leader>f", group = "Telescope" },
  { "<leader>ff", telebuilt.find_files, desc = "Find files" },
  -- {"<leader>fh", "<cmd>Telescope harpoon marks<cr>", "Harpoon marks" },
  { "<leader>fg", telebuilt.live_grep, desc = "Live grep" },
  { "<leader>fa", telebuilt.builtin, desc = "Telescope builtins" },
  { "<leader>ft", telebuilt.treesitter, desc = "Treesitter symbols" },
  { "<leader>fq", telebuilt.quickfix, desc = "Quickfix" },
  { "<leader>fl", telebuilt.loclist, desc = "Location list" },
  { "<leader>fp", telebuilt.oldfiles, desc = "Previous files" },
  { "<leader>fb", telebuilt.buffers, desc = "Open buffers" },
  { "<leader>fj", telebuilt.jumplist, desc = "Jump list" },
  { "<leader>fh", telebuilt.help_tags, desc = "Help tags" },
  { "<leader>fm", telebuilt.man_pages, desc = "Man pages" },
  {
    "<leader>fo",
    function()
      tele.extensions.project.project({ display_type = "full" })
    end,
    desc = "Search projects",
  },
  { "<leader>fd", vim.cmd.TodoTelescope, desc = "Find TODOs" },
  { "<leader>f/", telebuilt.current_buffer_fuzzy_find, desc = "Fuzzy find" },
})
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

-- {{{ LSP
--  AutoCMD from lspconfig readme.md, hotkeys and such modified by me
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    wk.add({
      { "<leader>q", vim.diagnostic.open_float, desc = "Floating diagnostic" },
    })

    wk.add({
      { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "[d", vim.diagnostic.goto_prev, desc = "Prev diagnostic" },
    })
    wk.add({ "K", vim.lsp.buf.hover, desc = "LSP Hover" }, opts)

    wk.add({
      { "<leader>l", group = "LSP" },
      { "<leader>lq", vim.diagnostic.setloclist, desc = "Set location list" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code action", opts },
      { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References", opts },
      { "<leader>lw", group = "Workspace folders" },
      { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add folder", opts },
      { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove folder", opts },
      {
        "<leaderlwl",
        function()
          local str = ""
          for i, v in ipairs(vim.lsp.buf.list_workspace_folders()) do
            str = str .. i .. ". " .. v .. "\n"
          end
          print(str)
        end,
        desc = "List folders",
        opts,
      },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols", opts },
      { "<leader>lS", vim.lsp.buf.signature_help, desc = "Signature help", opts },
      { "<leader>ln", vim.lsp.buf.rename, desc = "Rename", opts },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format",
        opts,
      },
      { "<leader>ld", vim.lsp.buf.definition, desc = "Definition", opts },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Declaration", opts },
      { "<leader>li", vim.lsp.buf.implementation, desc = "Implementation", opts },
      { "<leader>lt", vim.lsp.buf.type_definition, desc = "Type definition", opts },
      { "<leader>lv", require("telescope.builtin").diagnostics, desc = "Diagnostics" },
    })
  end,
})
-- }}}

-- {{{ Easy window movement with ctrl arrow
wk.add({
  {"<C-Up>", "<C-w>k",   desc="Go to the up window" },
  {"<C-Down>", "<C-w>j", desc="Go to the down window" },
  {"<C-Left>", "<C-w>h", desc="Go to the left window" },
  {"<C-Right>", "<C-w>l",desc="Go to the right window" },
}, {})
-- }}}

-- {{{ Text moving
wk.add({
  {"<M-Down>", ":move '>+1<cr>gv=gv", desc="Move lines down",mode = "v" },
  {"<M-Up>", ":move '<-2<cr>gv=gv",   desc="Move lines up",mode = "v" },
  {"<M-k>", ":move '<-2<cr>gv=gv",    desc="which_key_ignore",mode = "v" },
  {"<M-j>", ":move '>+1<cr>gv=gv",    desc="which_key_ignore",mode = "v" },
})
wk.add({
  {"<M-Down>", "V:move '>+1<cr>gv=gv",desc="Move lines down" },
  {"<M-Up>", "V:move '<-2<cr>gv=gv",  desc="Move lines up" },
  {"<M-k>", "V:move '<-2<cr>gv=gv",   desc="which_key_ignore" },
  {"<M-j>", "V:move '>+1<cr>gv=gv",   desc="which_key_ignore" },
})
-- }}}

-- {{{ Loose mappings
wk.add({
  {"<leader>x", "<cmd>Bdelete<cr>", desc="Delete buffer" },
  {"<leader>e", "<cmd>Neotree toggle=true<cr>", desc="Toggle Nvim tree" },
})

wk.add({
  {"<leader>w", "<cmd>WhichKey<cr>", desc="Open WhichKey",mode = { "n", "v" } },
})

-- }}}
