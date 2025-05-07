return {
  "neovim/nvim-lspconfig",
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          },
        },
      },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      pyright = {},
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
    local function setup_server(server_name, config)
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      require("lspconfig")[server_name].setup(config)
    end
    for server_name, server_opt in pairs(servers) do
      setup_server(server_name, server_opt)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('BeiMo-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map("gd", function ()
          local builtin = require("telescope.builtin")
          local params = vim.lsp.util.make_position_params(0, "utf-8")
          vim.lsp.buf_request(params.bufnr, "textDocument/definition", params, function(_, result, _, _)
            if not result or vim.tbl_isempty(result) then
              vim.notify("No definition found", vim.log.levels.INFO)
            else
              builtin.lsp_definitions()
            end
          end)
        end, "跳转到定义")
        map("<leader>gr", require('telescope.builtin').lsp_references, '查找引用')
        map("gI", require('telescope.builtin').lsp_implementations, '跳转到实现')
        map("<leader>D", require('telescope.builtin').lsp_type_definitions, '查看定义类型')
        map("<leader>rn", vim.lsp.buf.rename, '全局重命名')
        map("<leader>ds", require('telescope.builtin').lsp_document_symbols, '文档符号搜索')
        map("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols, '工作区符号搜索')
        map("gD", vim.lsp.buf.declaration, '跳转的声明')
        map("<leader>ca", vim.lsp.buf.code_action, '代码操作', { 'n', 'x' })
        map("<leader>ld", function()
          vim.diagnostic.open_float {
            source = true,
            border = "rounded"
          }
        end, "当前行诊断信息")
        map("<leader>td", (function()
          local diag_status = 1
          return function()
            if diag_status == 1 then
              diag_status = 0
              vim.diagnostic.config { underline = false, virtual_text = false, signs = false, update_in_insert = false }
            else
              diag_status = 1
              vim.diagnostic.config { underline = true, virtual_text = true, signs = true, update_in_insert = true }
            end
            vim.notify("诊断显示: " .. (diag_status == 1 and "开启" or "关闭"))
          end
        end)(), "诊断信息开关")
      end
    })
  end,
}
