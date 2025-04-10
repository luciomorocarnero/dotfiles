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
      local lspconfig_defaults = require("lspconfig").util.default_config
      lspconfig_defaults.capabilities =
        vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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
          vim.keymap.set(
            "n",
            "gR",
            "<cmd>lua vim.lsp.buf.rename()<cr>",
            { desc = "Rename the symbol", buffer = event.buf }
          )
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

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "astro", "eslint", "ts_ls", "volar", "cssls", "cssmodules_ls", "css_variables", "html"  },
          handlers = {
            function(server_name)
              local lspconfig = require("lspconfig")
              if server_name == "volar" then
                lspconfig.volar.setup({
                  -- NOTE: Uncomment to enable volar in file types other than vue.
                  -- (Similar to Takeover Mode)

                  -- filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

                  -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

                  -- root_dir = require("lspconfig").util.root_pattern(
                  --   "vue.config.js",
                  --   "vue.config.ts",
                  --   "nuxt.config.js",
                  --   "nuxt.config.ts"
                  -- ),
                  init_options = {
                    vue = {
                      hybridMode = false,
                    },
                    -- NOTE: This might not be needed. Uncomment if you encounter issues.

                    -- typescript = {
                    --   tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
                    -- },
                  },
                  settings = {
                    typescript = {
                      inlayHints = {
                        enumMemberValues = {
                          enabled = true,
                        },
                        functionLikeReturnTypes = {
                          enabled = true,
                        },
                        propertyDeclarationTypes = {
                          enabled = true,
                        },
                        parameterTypes = {
                          enabled = true,
                          suppressWhenArgumentMatchesName = true,
                        },
                        variableTypes = {
                          enabled = true,
                        },
                      },
                    },
                  },
                })
              elseif server_name == "ts_ls" then
                local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
                local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

                lspconfig.ts_ls.setup({
                  -- NOTE: To enable hybridMode, change HybrideMode to true above and uncomment the following filetypes block.
                  -- WARN: THIS MAY CAUSE HIGHLIGHTING ISSUES WITHIN THE TEMPLATE SCOPE WHEN TSSERVER ATTACHES TO VUE FILES

                  -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                  init_options = {
                    plugins = {
                      {
                        name = "@vue/typescript-plugin",
                        location = volar_path,
                        languages = { "vue" },
                      },
                    },
                  },
                  settings = {
                    typescript = {
                      inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                      },
                    },
                  },
                })
              else
                lspconfig[server_name].setup({})
              end
            end,
          },
      })

      -- Specific Config for LSPs
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
}
