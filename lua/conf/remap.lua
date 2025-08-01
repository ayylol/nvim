-- leader key
vim.keymap.set("", " ", "<nop>")
vim.g.mapleader=" "
vim.g.maplocalleader=","

-- netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Tab navigation
vim.keymap.set("n", "gt", "<nop>")
vim.keymap.set("n", "<leader>k", "gt")
vim.keymap.set("n", "<leader>j", "gT")

-- Split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- Split resizing
vim.keymap.set("n", "<leader>=", ":resize +2<CR>", {silent=true})
vim.keymap.set("n", "<leader>-", ":resize -2<CR>", {silent=true})
vim.keymap.set("n", "<leader>.", ":vertical resize +2<CR>", {silent=true})
vim.keymap.set("n", "<leader>,", ":vertical resize -2<CR>", {silent=true})

-- Clear search highlight
vim.keymap.set("n", "<esc>", "<esc>:noh<CR>",{silent=true})

-- Keep Cursor Centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "J", "mzJ`z") -- Don't move cursor when joining lines

-- New lines without going into edit mode
vim.keymap.set("n", "go", "o<esc>")
vim.keymap.set("n", "gO", "O<esc>")

-- Stay in visual mode when indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy Paste 
-- Paste over without overwriting buffer
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "d", [[d]]) -- cut

-- Copy/Paste from clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>p", "o<esc>\"+p")
vim.keymap.set("v", "<leader>p", "o<esc>\"+p")
vim.keymap.set("n", "<leader>P", "o<esc>\"+P")

vim.keymap.set("v", "<leader>aa", "\"zy:let @z=system(\"clang-format\",@z)<CR>gv\"zp")

vim.keymap.set("v", "<leader>ss", "mz\"zy:silent g `<C-r>z<CR>'z")
