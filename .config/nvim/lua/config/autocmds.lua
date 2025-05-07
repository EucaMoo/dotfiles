-- 复制时高亮复制内容
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Telescope 预览界面显示行号
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
    callback = function()
      vim.opt_local.number = true
    end,
})

-- lua文件缩进设置为2
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
