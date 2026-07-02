-- leader key
vim.keymap.set("", " ", "<nop>")
vim.g.mapleader=" "
vim.g.maplocalleader=","

-- Tab navigation
vim.keymap.set("n", "gt", "<nop>")
vim.keymap.set("n", "<leader>k", "gt", { desc = "next tab"})
vim.keymap.set("n", "<leader>j", "gT", { desc = "prev tab"})

-- Split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "down split"})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "up split"})
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "right split"})
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "left split"})

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

-- netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Telescope
local telescope_bi = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_bi.find_files, {})
vim.keymap.set('n', '<leader>fr', telescope_bi.oldfiles, {})
vim.keymap.set('n', '<leader>fs', telescope_bi.live_grep, {})
vim.keymap.set('n', '<leader>fc', telescope_bi.grep_string, {})
vim.keymap.set('n', '<leader>fb', telescope_bi.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_bi.help_tags, {})
vim.keymap.set('n', '<leader>fk', telescope_bi.keymaps, {})

-- LSP
-- TODO: use <leader>l as a prefix for all LSP commands
-- TODO: change telescope diagnostics and lsp restart commands
vim.keymap.set("n", "gR", telescope_bi.lsp_references, {}) -- show definition, references
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {}) -- go to declaration
vim.keymap.set("n", "gd", telescope_bi.lsp_definitions, {}) -- show lsp definitions
vim.keymap.set("n", "gi", telescope_bi.lsp_implementations, {}) -- show lsp implementations
vim.keymap.set("n", "gt", telescope_bi.lsp_type_definitions, {}) -- show lsp type definitions
vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
vim.keymap.set("n", "<leader>rs", ":lsp restart<CR>", opts) -- mapping to restart lsp if necessary

-- Autorun go.sh
-- TODO: Assumes nvim is in the dir with go.sh, do something to look up dirs
-- TODO: pipe output to a log file
function EZlaunch()
  local cwd = vim.fn.getcwd(0)
  if (os.execute(cwd.."/go.sh > ./log.txt 2>&1")~=0) then
    vim.notify("RUN FAILED!", vim.log.levels.ERROR)
  end
end
vim.keymap.set("n", "<leader>gg", EZlaunch, {})
