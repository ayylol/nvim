return {
  "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000,
  config = function()

    function Recolor()
      vim.opt.termguicolors = true
      vim.opt.syntax="on" 
      vim.cmd('colorscheme moonfly')
      vim.cmd('hi ColorColumn guibg=#ff5454')
      vim.cmd('hi CursorLineNr guifg=#e3c78a')
      vim.cmd('hi LineNr guibg=NONE')
      vim.cmd('hi SignColumn guibg=NONE')
      -- vim.cmd('hi Comment guifg=grey')
      -- vim.cmd('hi Folded guifg=grey')
      vim.cmd('hi Normal guibg=NONE')
      -- TSEnable highlight
    end
    Recolor()
  end,
}
