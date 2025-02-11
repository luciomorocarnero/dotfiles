-- lpsconfig.lua
require("lspconfig").basedpyright.setup({
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        reportMissingTypeStubs = false,
        reportMissingImports = false,
        reportOptionalSubscript = false,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})
