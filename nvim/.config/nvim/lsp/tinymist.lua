return {
  root_dir = vim.fn.getcwd(),
  filetypes = { "typst", "typ" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "enable",
  },
}
