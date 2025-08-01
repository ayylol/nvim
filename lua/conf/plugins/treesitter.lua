return {
  "nvim-treesitter/nvim-treesitter",
  priority = 1001, -- load before color script
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp"},
      auto_install = true,
      highlight = { 
        enable = true, 
      },
    })
  end,
}
