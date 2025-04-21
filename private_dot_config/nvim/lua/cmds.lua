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

    vim.keymap.set(
      "n",
      "K",
      "<cmd>lua vim.lsp.buf.hover()<cr>",
      { desc = "Show documentation for the symbol under cursor", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<cr>",
      { desc = "[g]oto [d]efinition", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<cr>",
      { desc = "[g]oto [D]eclaration", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gi",
      "<cmd>lua vim.lsp.buf.implementation()<cr>",
      { desc = "[g]oto [i]mplementation", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "go",
      "<cmd>lua vim.lsp.buf.type_definition()<cr>",
      { desc = "[g]oto type definition [o]f the symbol", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "<leader>sS",
      telescope.lsp_document_symbols,
      { desc = "[s]earch [S]ymbols", buffer = event.buf }
    )
    vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "[g]oto [r]eferences", buffer = event.buf })
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
    vim.keymap.set(
      "n",
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { desc = "[c]ode [a]ction: Show available code actions", buffer = event.buf }
    )
  end,
})
