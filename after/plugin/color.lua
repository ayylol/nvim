function Recolor()
    vim.opt.termguicolors = true
    vim.opt.syntax="on" 
    vim.cmd('colorscheme moonfly')
    -- vim.cmd('hi Comment guifg=grey')
    -- vim.cmd('hi Folded guifg=grey')
    vim.cmd('hi Normal guibg=NONE')
    -- TSEnable highlight
end
Recolor()
