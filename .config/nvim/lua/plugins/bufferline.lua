return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    { "nvim-tree/nvim-web-devicons",enabled = vim.g.have_nerd_font },
  },
  config = function ()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          local symbols = {
            error = " ",
            warning = " ",
            info = " "
          }
          local s = ""
          for _, level in ipairs({ "error", "warning", "info" }) do
            if diagnostics_dict[level] then
              s = s .. " " .. diagnostics_dict[level] .. symbols[level]
            end
          end
          return s
        end
      },
    })
  end
}
