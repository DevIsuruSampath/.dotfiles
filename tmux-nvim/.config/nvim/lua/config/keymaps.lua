local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>h", "<C-w>h", { desc = "Go left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Go down window" })
map("n", "<leader>k", "<C-w>k", { desc = "Go up window" })
map("n", "<leader>l", "<C-w>l", { desc = "Go right window" })
