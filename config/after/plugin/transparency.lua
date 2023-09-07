-- Change theme after transparency is loaded to avoid a flash
local colorpath = vim.fn.stdpath "data" .. "/colorscheme.vim"

if vim.fn.glob(colorpath) ~= "" then
  vim.cmd.source(colorpath)
end
