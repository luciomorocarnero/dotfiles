return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
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
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "astro",
          "eslint",
          "ts_ls",
          "volar",
          "cssls",
          "cssmodules_ls",
          "css_variables",
          "html",
          "harper_ls",
          "tinymist",
        },
        automatic_installation = true,
      })

      local handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
          })
        end,
        -- overrides for specific servers.
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifierPreference = "relative",
              },
            },
          })
        end,
        ["astro"] = function()
          lspconfig.astro.setup({
            capabilities = lsp_capabilities,
            filetypes = { "astro" },
            settings = {
              astro = {},
              init_options = { typescript = {} },
            },
          })
        end,
        ["css_variables"] = function()
          lspconfig.css_variables.setup({
            capabilities = lsp_capabilities,
            filetypes = { "css", "scss", "less", "astro" },
            settings = {
              cssVariables = {
                blacklistFolders = {
                  "**/.cache",
                  "**/.DS_Store",
                  "**/.git",
                  "**/.hg",
                  "**/.next",
                  "**/.svn",
                  "**/bower_components",
                  "**/CVS",
                  "**/dist",
                  -- "**/node_modules",
                  "**/tests",
                  "**/tmp",
                },
                lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
              },
            },
          })
        end,
        ["harper_ls"] = function()
          -- lspconfig.harper_ls.setup({
          --   settings = {
          --     ["harper-ls"] = {
          --       userDictPath = "~/Documents/dicts/es.txt",
          --       fileDictPath = "",
          --       linters = {
          --         SpellCheck = true,
          --         SpelledNumbers = false,
          --         AnA = true,
          --         SentenceCapitalization = true,
          --         UnclosedQuotes = true,
          --         WrongQuotes = false,
          --         LongSentences = true,
          --         RepeatedWords = true,
          --         Spaces = true,
          --         Matcher = true,
          --         CorrectNumberSuffix = true,
          --       },
          --       codeActions = {
          --         ForceStable = false,
          --       },
          --       markdown = {
          --         IgnoreLinkTitle = false,
          --       },
          --       diagnosticSeverity = "hint",
          --       isolateEnglish = false,
          --     },
          --   },
          -- })
        end,
        ["tinymist"] = function()
          lspconfig.tinymist.setup({
            capabilities = lsp_capabilities,
            filetypes = { "typst" },
            settings = {
              formatterMode = "typstyle",
              -- exportPdf = "onType",
              semanticTokens = "disable",
            },
          })
        end,
      }

      require("mason-lspconfig").setup_handlers(handlers)
    end,
  },
}
