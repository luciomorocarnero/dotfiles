-- paste without copy
-- vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

vim.keymap.set({"n", "v"}, "H", "^", { desc = "Go to beginning of line" })
vim.keymap.set({"n", "v"}, "L", "$", { desc = "Go to end of line" })

--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason" })

-- Normal mode in terminal
-- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {silent = true, noremap = true})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
