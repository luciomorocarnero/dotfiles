return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        autoSearchPaths = true,
        diagnosticSeverityOverrides = {
          reportAttributeAccessIssue = "none",
          reportGeneralTypeIssues = "none",
        },
        stubPath = "typings",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
