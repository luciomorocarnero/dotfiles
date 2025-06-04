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
    },
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        -- automatic_enable = false,
        ensure_installed = {
          "lua_ls",
          "basedpyright",
          "astro",
          "tailwindcss",
          "eslint",
          "ts_ls",
          -- "volar",
          "cssls",
          "cssmodules_ls",
          "css_variables",
          "html",
          "tinymist",
          "clangd",
        },
        automatic_installation = true,
      })

      vim.lsp.config("*", {
        capabilities = lsp_capabilities,
        root_markers = { ".git" },
      })
    end,
  },
}
