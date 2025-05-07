local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 行号
opt.relativenumber = true
opt.number = true

-- 按键等待时间
opt.ttimeoutlen = 0
opt.timeout = false

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- 智能缩进
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- 不区分大小写
opt.ignorecase = true
opt.smartcase = true

-- 字符包裹和自动折行
opt.wrap = false
opt.breakindent = true
vim.opt.showbreak = "↳ "

-- 自动切换目录
opt.autochdir = true

-- 撤销持久化
opt.undofile = true

-- 模式转换提示
opt.showmode = false

-- 光标行和光标
opt.cursorline = true
opt.guicursor = {
  "a:blinkwait300-blinkon200-blinkoff150",
  "c:hor25",
  "i-ci:ver20",
}
-- 光标上下保留的最小行数
opt.scrolloff = 10

-- 鼠标设置
opt.mouse = "a"

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- 减少内部更新时间
opt.updatetime = 50

-- 减少键盘映射等待时间
opt.timeoutlen = 300

-- 新窗口在右和下打开
opt.splitright = true
opt.splitbelow = true

-- 设置Neovim如何显示空白字符
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }

-- 在输入时实时预览
opt.inccommand = "nosplit"
