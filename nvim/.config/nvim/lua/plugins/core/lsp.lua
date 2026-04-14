return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- LSP
          "lua_ls",
          "basedpyright",
          "hyprls",
          "bashls",
          "yamlls",
          "tinymist",
          "rust_analyzer",
          -- "docker_language_server",
          -- "astro",
          -- "tailwindcss",
          -- "eslint",
          -- "ts_ls",
          -- "volar",
          -- "cssls",
          -- "cssmodules_ls",
          -- "css_variables",
          -- "html",
          -- "tinymist",
          -- "clangd",
          -- "yamlls",
        },
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "isort",
          "stylua",
          "beautysh",
        },
      })

      vim.lsp.config("*", {
        capabilities = lsp_capabilities,
        root_markers = { ".git" },
      })
    end,
  },
}
