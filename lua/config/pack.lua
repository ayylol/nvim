-- Shorter URLS
gh = function(x) return 'https://github.com/' .. x end
cb = function(x) return 'https://codeberg.org/' .. x end

local function run_build(spec, path)
  local build = spec.data and spec.data.build
  if not build then return end

  vim.system({ "sh", "-c", build }, {
    cwd = path,
    text = true,
  })
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind == "install" or ev.data.kind == "update" then
      run_build(ev.data.spec, ev.data.path)
    end
  end,
})

-- TODO: use version tags instead of branch names so its more stable
vim.pack.add({
-- Color Scheme
{ src=gh('bluz71/vim-moonfly-colors'),
  name='color-scheme', version='master'},

-- Tabline
{ src=gh('crispgm/nvim-tabline'),
  name='tabline', version='main'},

-- Telescope
{ src=gh('nvim-lua/plenary.nvim'),
  name='plenary', version='master'},
{ src=gh('nvim-telescope/telescope-fzf-native.nvim'),
  name='fzf-native', version='main', data={build="make"}},
{ src=gh('nvim-telescope/telescope.nvim'),
  name='telescope', version='master'},

-- LSP
{ src=gh('neovim/nvim-lspconfig'),
  name='lspconfig', version='master'},

-- Orgmode
{ src=gh('nvim-orgmode/orgmode'),
  name='orgmode', version='master'},
})
