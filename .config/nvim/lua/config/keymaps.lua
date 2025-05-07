local keymap = vim.keymap
-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-l>", "<C-w><C-l>")
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-k>", "<C-w><C-k>")

-- 取消高亮
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 切换buffer
keymap.set("n", "<C-L>", "<cmd>bnext<CR>")
keymap.set("n", "<C-H>", "<cmd>bprevious<CR>")
keymap.set("n", "<leader>bc", "<cmd>bd<CR>")
