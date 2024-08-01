return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  version = "*",
  config = function()
    --[[
    local neorg = require("neorg")
    neorg.setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Documents/notes"
            },
            default_workspace = "notes",
          },
        },
      }
    })
    vim.keymap.set("n", "<leader>nn", ":Neorg<cr>")
    ]]-- 
  end,
}
