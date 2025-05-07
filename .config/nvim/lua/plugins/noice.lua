return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify",
      opts = {
        level = 2,
        render = 'wrapped-compact',
        stages = 'slide',
        timeout = 1000,
        max_height = function()
          return math.ceil(vim.api.nvim_win_get_height(0) * 0.55)
        end,
        max_width = function()
          return math.ceil(vim.api.nvim_win_get_width(0) * 0.55)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      }
    },
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
}
