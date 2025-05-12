return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",
      ["<C-e>"] = { "show", "hide"},
      ["<CR>"] = { "accept", "fallback" },

      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    cmdline = {
      enabled = true,
      completion = {
        menu = { auto_show = false },
        ghost_text = { enabled = true },
      },
    },

    enabled = function()
      return not vim.tbl_contains({
        "markdown",
      }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded"
      },
      keyword = {
        range = "full"
      },
      list = {
        selection = { preselect = false, auto_insert = true }
      },
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = true,
        show_with_menu = true,
        show_without_menu = true,
      },
    },

    signature = {
      enabled = true,
      window = { border = "rounded" }
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        snippets = { score_offset = 4},
        buffer = { score_offset = 3},
        lsp = { score_offset = 2},
        path = { score_offset = 1},
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
