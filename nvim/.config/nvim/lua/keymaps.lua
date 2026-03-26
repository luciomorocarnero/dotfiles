vim.keymap.set({"n", "v"}, "H", "^", { desc = "Go to beginning of line" })
vim.keymap.set({"n", "v"}, "L", "$", { desc = "Go to end of line" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
