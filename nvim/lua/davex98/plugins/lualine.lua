return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        theme = "gruvbox",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "lsp_progress" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
