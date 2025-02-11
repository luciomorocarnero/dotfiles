--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>cc", function()
  vim.cmd(":Huefy")
end, { desc = " [C]olorPicker" })

-- BarBar Plugin
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
map("n", "<A-x>", "<Cmd>BufferClose!<CR>", opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)

-- cerrar todos menos el que esta activo
map(
  "n",
  "<leader>bo",
  "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
  { noremap = true, silent = true, desc = "Delete all Buffers but [O]current" }
)

-- Sort automatically by...
map(
  "n",
  "<leader>bb",
  "<Cmd>BufferOrderByBufferNumber<CR>",
  { noremap = true, silent = true, desc = "Order by [N]UMBER" }
)
map("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", { noremap = true, silent = true, desc = "Order by [N]AME" })
map(
  "n",
  "<leader>bd",
  "<Cmd>BufferOrderByDirectory<CR>",
  { noremap = true, silent = true, desc = "Order by [D]IRECTORY" }
)
map(
  "n",
  "<leader>bl",
  "<Cmd>BufferOrderByLanguage<CR>",
  { noremap = true, silent = true, desc = "Order by [L]ANGUAGE" }
)
map(
  "n",
  "<leader>bw",
  "<Cmd>BufferOrderByWindowNumber<CR>",
  { noremap = true, silent = true, desc = "Order by [W]INDOW_NUMBER" }
)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Treesj
map("n", "<leader>ct", "<cmd>lua require('treesj').toggle()<cr>", { desc = "[T]reesj" })

-- LSP_LINES
vim.keymap.set("", "<Leader>ul", "<cmd>lua require('lsp_lines').toggle()<cr>", { desc = "Toggle lsp_lines" })

-- File Commands
map(
  "n",
  "<leader>fn",
  "<Cmd>lua vim.fn.setreg('+', vim.fn.expand('%:t'))<CR>",
  { noremap = true, silent = true, desc = "[f]ile [n]ame" }
)

map(
  "n",
  "<leader>fp",
  "<Cmd>lua vim.fn.setreg('+', vim.fn.expand('%:p'):sub(#vim.fn.getcwd() + 2))<CR>",
  { noremap = true, silent = true, desc = "[f]ile [p]ath relative" }
)

map(
  "n",
  "<leader>fP",
  "<Cmd>lua vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>",
  { noremap = true, silent = true, desc = "[f]ile [P]ath complete" }
)

map(
  "n",
  "<leader>fo",
  "<Cmd>lua vim.fn.jobstart('xdg-open ' .. vim.fn.expand('%:p:h'))<CR>",
  { noremap = true, silent = true, desc = "[f]ile [o]pen in file explorer" }
)

map(
  "n",
  "<leader>fg",
  "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
  { noremap = true, silent = true, desc = "[f]ile [g]rep in current file" }
)

map("n", "<leader>fw", "<Cmd>SudaWrite<CR>", { noremap = true, silent = true, desc = "[f]ile [w]rite with sudo" })

map("", "<leader>li", ":Gen<CR>", { noremap = true, silent = true, desc = "[I]A" })

vim.keymap.set("n", "<leader>fc", function()
  local file_path = vim.fn.expand("%:p")
  local content = table.concat(vim.fn.readfile(file_path), "\n")
  vim.fn.setreg("+y", "<Path>: " .. file_path .. "</Path>" .. "\n\n<Content>\n" .. content .. "\n\n</Content>")
  -- print("✓ Archivo copiado: " .. file_path)
end, { noremap = true, silent = false, desc = "[F]ile [C]opy path + content" })
