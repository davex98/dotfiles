return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
  config = function()
    local flash = require("flash")
    flash.setup({
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
      },
    })
  end,
}
