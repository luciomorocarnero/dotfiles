return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    vim.opt.termguicolors = true
    require("nvim-highlight-colors").setup({})
    require("cmp").setup({
      formatting = {
        format = require("nvim-highlight-colors").format,
      },
    })
    vim.keymap.set("n", "<leader>uH", "<cmd>HighlightColors Toggle<cr>", { desc = "toggle [h]ighlight colors" })
  end,
}
