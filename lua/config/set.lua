vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.scrolloff=8
vim.opt.colorcolumn="100"
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
  require('todo-comments').setup { signs = false }
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
notes_dir = '~/Documents/Notes'
local orgmode = require('orgmode')
orgmode.setup({
      org_agenda_files = notes_dir..'/**/*',
      org_default_notes_file = notes_dir..'/refile.org',
      org_startup_folded= 'showeverything',
      org_capture_templates = {
        -- TODO: Make this capture work so it automatically grabs the files in logs dir
        t = {
            description = "Project todos",
            -- TODO: add tags as options
            template = "* TODO %^{TITLE|} :%^{TAGS|misc}:\n%?",
            target = notes_dir..'/todos/%^{file|todo.org|tree.org|graphics.org|gamedev.org|compilers.org}',
            datetree = {
              tree_type = 'day',
            }
        }
      }
})


--Telescope startup
local telescope = require('telescope')
telescope.setup({
  defaults = { },
})
if (os.execute('which fzf > /dev/null 2>&1') == 0)
then
  telescope.load_extension('fzf')
end

-- LSP
vim.lsp.enable({'clangd'})
--vim.lsp.enable({'gdscript'}) -- TODO: Check
vim.lsp.enable({'ols'})
vim.lsp.enable({'zls'})

-- Completion Engine
require('blink.cmp').setup({
    keymap = { preset = 'default', },
    appearance = { nerd_font_variant = 'mono', },
    completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 }, },
    sources = { default = { 'lsp', 'path', 'snippets' }, },
    snippets = { preset = 'luasnip' },
    -- TODO: change to rust
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
})

-- turn off diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
