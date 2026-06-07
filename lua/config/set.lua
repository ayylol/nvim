vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.scrolloff=8
vim.opt.colorcolumn="80"
vim.opt.incsearch=true
vim.opt.cursorline=true
vim.wo.signcolumn="no"
--vim.opt.mouse=""

vim.opt.filetype="on"
vim.opt.syntax="on"
vim.opt.wrap=false
vim.opt.swapfile=false

--vim.opt.shortmess:append({ S = false })

function setTabs(tabsize)
  vim.opt.tabstop=tabsize
  vim.opt.softtabstop=tabsize
  vim.opt.shiftwidth=tabsize
  vim.opt.expandtab=true
  vim.opt.autoindent=true
end
setTabs(2)

-- Color Scheme
function Recolor()
  vim.opt.termguicolors = true
  vim.opt.syntax='on' 
  vim.cmd('colorscheme moonfly')
  vim.cmd('hi ColorColumn guibg=#ff5454')
  vim.cmd('hi CursorLineNr guifg=#e3c78a')
  vim.cmd('hi LineNr guibg=NONE')
  vim.cmd('hi SignColumn guibg=NONE')
  vim.cmd('hi Normal guibg=NONE')
end
Recolor()

-- Tabline
local tabline=require('tabline')
tabline.setup({
    show_index = true,           -- show tab index
    show_modify = true,          -- show buffer modification indicator
    show_icon = false,           -- show file extension icon
    fnamemodify = ':t',          -- file name modifier string
                                 -- can be a function to modify buffer name
    modify_indicator = '[+]',    -- modify indicator
    no_name = 'No name',         -- no name buffer name
    brackets = { '[', ']' },     -- file name brackets surrounding
    inactive_tab_max_length = 0  -- max length of inactive tab titles, 0 to ignore
})
vim.opt.showtabline = 2

-- Orgmode
local orgmode = require('orgmode')
orgmode.setup({
      org_agenda_files = '~/Documents/notes/**/*',
      org_default_notes_file = '~/Documents/notes/refile.org',
})

-- Telescope startup
local telescope = require('telescope')
telescope.setup({
  defaults = { },
})
telescope.load_extension('fzf')

-- LSP
-- TODO: Check gdscript
vim.lsp.enable({'clangd'})
vim.lsp.enable({'gdscript'})
-- turn off diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
