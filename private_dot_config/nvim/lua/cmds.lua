-- Save with W
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }
    local telescope = require("telescope.builtin")

    if vim.g.have_nerd_font then
      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config({ signs = { text = diagnostic_signs } })
    end

    vim.lsp.enable("lua_ls")

    vim.keymap.set(
      "n",
      "K",
      "<cmd>lua vim.lsp.buf.hover()<cr>",
      { desc = "Show documentation for the symbol under cursor", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gs",
      "<cmd>lua vim.lsp.buf.signature_help()<cr>",
      { desc = "Show signature help for the function", buffer = event.buf }
    )
    vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename the symbol", buffer = event.buf })
    vim.keymap.set(
      { "n", "x" },
      "<F3>",
      "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
      { desc = "Format the current buffer", buffer = event.buf }
    )
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.*" },
  desc = "save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*" },
  desc = "load view (folds), when opening file",
  command = "silent! loadview",
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many", border = "rounded", show_header = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "txt" },
  desc = "Set gq format keymap for txt files",
  callback = function()
    vim.keymap.set("n", "<leader>cq", "ggVGgq", { desc = "Format file with gq", buffer = true })
  end,
})

vim.api.nvim_create_user_command("Focus", function()
  Snacks.zen()
  vim.cmd("Pencil")
  vim.cmd("Limelight")
end, { nargs = 0 })
