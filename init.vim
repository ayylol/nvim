" Misc {{{
set nocompatible
set encoding=UTF-8

set noswapfile
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set scrolloff=8
set colorcolumn=80
set termguicolors
set incsearch
"set nohlsearch
"au FileType * set fo-=c fo-=r fo-=o
au FileType * set fo-=o

filetype plugin indent on

set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

map <space> <Nop>
let mapleader=" "

set foldmethod=marker
set syntax=on
set nowrap

set relativenumber
set number

set mouse=a

command Src :source ~/.config/nvim/init.vim

"}}}
" Plugins{{{

call plug#begin('~/.vim/plugged')
    " LSP
    Plug 'neovim/nvim-lspconfig'
    " AutoComplete
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    " Snippets for auto complete
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    " Syntax Colors
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Fuzzy file finder
    Plug 'nvim-lua/plenary.nvim' " Needed as dependency for telescope
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    " Git
    Plug 'tpope/vim-fugitive'
    " File Explorer
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'
    " Zen Mode
    Plug 'junegunn/goyo.vim'
    " Color Schemes
    Plug 'bluz71/vim-moonfly-colors'
call plug#end()

" LSP {{{ 
lua require 'nvim-treesitter'.setup()
" Vsnip{{{
"imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
"}}}
" lspconfig{{{
"lua local opts = { buffer = ev.buf }
lua vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
lua vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
lua vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
lua vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
lua vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
"}}}
" Nonsense from cmp {{{
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
EOF
"}}}

"}}}

" Goyo {{{

function! s:goyo_enter()
    set rnu
    set nu
endfunction

function! s:goyo_leave()
    call Recolor()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = 100

nnoremap <leader>z :Goyo<CR>

"}}}

" Telescope {{{
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }}}

"nvim tree{{{
lua vim.g.loaded_netrw = 1
lua vim.g.loaded_netrwPlugin = 1
lua require("nvim-tree").setup()

nnoremap <leader>e :NvimTreeToggle<CR>
"}}}

" }}}
" Colors {{{

function Recolor()
    syntax enable
    colorscheme moonfly
    "hi Comment guifg=grey
    "hi Folded guifg=grey
    hi Normal guibg=NONE
    TSEnable highlight
endfunc

call Recolor()

"}}}
" Tabs{{{
function SetTabs(tabsize)
    execute "set tabstop=".a:tabsize
    execute "set softtabstop=".a:tabsize
    execute "set shiftwidth=".a:tabsize
    set expandtab
    set autoindent
endfunc

call SetTabs(4)

" }}}
" Splits/Tabs{{{

" Split navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Move window around tabs
" tab move functions{{{
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
"}}}

nnoremap <A-.> :call MoveToNextTab()<CR>
nnoremap <A-,> :call MoveToPrevTab()<CR>

" Resize splits
nnoremap <silent> <Leader>= :resize +2<CR>
nnoremap <silent> <Leader>- :resize -2<CR> 
nnoremap <silent> <Leader>. :vertical resize +2<CR>
nnoremap <silent> <Leader>, :vertical resize -2<CR> 

"}}}
" Misc Rebinds{{{
" Adding new lines
nnoremap go o<esc>
nnoremap gO O<esc>

" Clear highlight
nnoremap <silent> <esc> <esc>:noh<CR>

" Keep cursor in the middle of the screen while doing <C-d> and <C-u>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor in middle when going through searches
nnoremap n nzz
nnoremap N Nzz

" Make J keep cursor in place
nnoremap J mzJ`z

" Stay in visual mode when indenting text
vnoremap > >gv
vnoremap < <gv

" Move highlighted text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Paste over without changing register
xnoremap <leader>x "_dP

" System clipboard copy
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" System clipboard paste
" TODO see if pasting to new line is annoying
nnoremap <leader>p o<esc>"+p
vnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p

" Delete into void
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>D "_D

" Make current file executable
" nnoremap <silent><leader>e :!chmod +x %<CR><CR>
" nnoremap <silent><leader>rr :!./%<CR>

" }}}