return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = "amongus",
      options = {
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    })
  end
}
