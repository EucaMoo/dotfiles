local M = {}
local state = {
  win = nil,
  buf = nil
}

local default_opts = {
  command = nil,
  shell = os.getenv("SHELL") or "bash",
  shell_args = {"-i"},
  min_size = {
    width = 40,
    height = 10
  },
  window = {
    size_ratio = 0.8,
    border = "rounded",
    title = " 🐚 Floating Terminal ",
    title_pos = "center",
    footer = " BeiMo ",
    footer_pos = "right",
  },
  termopen = {
    auto_insert = true
  }
}

-- 合并配置的辅助函数
local function merge_config(user_opts)
  local config = vim.tbl_deep_extend("force", {}, default_opts)
  if user_opts then
    config = vim.tbl_deep_extend("force", config, user_opts)
    if user_opts.command then
      config.shell = nil
      config.shell_args = {}
    end
  end
  return config
end

-- 核心创建函数
function M.create(user_opts)
  local config = merge_config(user_opts)

  -- 窗口复用检查
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_set_current_win(state.win)
    return
  end

  -- 创建新缓冲区
  state.buf = vim.api.nvim_create_buf(false, true)

  -- 终端初始化配置
  vim.api.nvim_create_autocmd("TermOpen", {
    buffer = state.buf,
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      if config.termopen.auto_insert then
        vim.cmd.startinsert()
      end
    end
  })

  -- 动态计算窗口尺寸
  local width = math.max(
    math.floor(vim.o.columns * config.window.size_ratio),
    config.min_size.width
  )
  local height = math.max(
    math.floor(vim.o.lines * config.window.size_ratio),
    config.min_size.height
  )

  -- 创建浮动窗口
  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2 - 2,
    style = "minimal",
    border = config.window.border,
    title = config.window.title,
    title_pos = config.window.title_pos,
    footer = config.window.footer,
    footer_pos = config.window.footer_pos
  })

  -- 构建命令参数
  local argv
  if config.command then
    argv = type(config.command) == "table" and config.command or {config.command}
  else
    argv = {config.shell}
    vim.list_extend(argv, config.shell_args)
  end

  -- 启动终端进程
  vim.fn.termopen(argv, {
    on_exit = function(_, code)
      if code == 0 then
        M.close()
      end
    end
  })

  -- 自动清理
  vim.api.nvim_create_autocmd({"TermClose", "BufDelete"}, {
    buffer = state.buf,
    callback = function()
      M.close()
    end
  })
end

-- 关闭浮动窗口
function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
  state.buf = nil
end

-- 初始化配置（可选）
function M.setup(custom_opts)
  default_opts = vim.tbl_deep_extend("force", default_opts, custom_opts or {})
end

return M
