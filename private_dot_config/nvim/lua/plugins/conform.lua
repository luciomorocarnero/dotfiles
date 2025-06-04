-- lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },

          svelte = { "prettierd", "prettier", stop_after_first = true },
          astro = { "prettierd", "prettier", stop_after_first = true },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          graphql = { "prettierd", "prettier", stop_after_first = true },
          vue = { "prettier", "prettierd", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettier", "prettierd", stop_after_first = true },
          css = { "prettier", "prettierd", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          --   bash = { "beautysh" },
          --   rust = { "rustfmt" },
          --   yaml = { "yamlfix" },
          --   toml = { "taplo" },
          --   sh = { "shellcheck" },
          --   go = { "gofmt" },
          --   xml = { "xmllint" },
          -- http = {"kulala-fmt"}
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
