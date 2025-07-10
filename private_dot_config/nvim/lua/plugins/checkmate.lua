return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("checkmate").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set({ "n", "v" }, "<CR>", function()
          require("checkmate").toggle()
        end, { desc = "Checkmate toggle", buffer = true })
      end,
    })
  end,
}
