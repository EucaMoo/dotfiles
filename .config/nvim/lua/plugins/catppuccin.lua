return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      term_colors = true,
      integrations = {
        bufferline = true,
      },
    })
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
