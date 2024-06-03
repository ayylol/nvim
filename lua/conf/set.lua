vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.scrolloff=8
vim.opt.colorcolumn="80"
vim.opt.incsearch=true
vim.opt.cursorline=true
vim.wo.signcolumn="yes"

vim.opt.filetype="on"
vim.opt.syntax="on"
vim.opt.wrap=false

vim.opt.shortmess:append({ S = false })

function setTabs(tabsize)
  vim.opt.tabstop=tabsize
  vim.opt.softtabstop=tabsize
  vim.opt.shiftwidth=tabsize
  vim.opt.expandtab=true
  vim.opt.autoindent=true
end
setTabs(2)
