-- Cool sets and options
vim.o.number = true
vim.o.scrolloff = 6

-- Show dots for trailing spaces
vim.o.list = true
vim.opt.listchars:append({ trail = '•' })

-- Persistent undo
vim.o.undofile = true

-- Tab key stuff
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Use {{{}}} :D
vim.o.foldmethod = "marker"

-- Much nicer
vim.o.autoindent = true

-- Stop the thing from popping in and out
vim.o.signcolumn = "yes:1"

