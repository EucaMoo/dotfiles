vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",  -- 匹配所有主题
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#c0c0c0" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#33ffcc", bold = true })
    vim.api.nvim_set_hl(0, "CursorLine", { bold = true, italic = true, bg = nil, fg = nil })
  end,
})
