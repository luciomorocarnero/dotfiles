return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<M-h>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<M-l>", "<Cmd>BufferNext<CR>", opts)
    map("n", "<M-Tab>", "<C-^>", opts)

    -- Delete current buffer
    map("n", "<A-x>", "<Cmd>BufferClose!<CR>", opts)

    -- Delete all other buffers
    map("n", "<A-o>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
  end,
  opts = {
    animation = false,
    icons = {
      separator = { left = "", right = "" },
      separator_at_end = false,
    },
  },
}
