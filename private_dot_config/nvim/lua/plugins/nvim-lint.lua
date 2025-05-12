return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")
    local lint_enabled = true
    local diagnostic_enabled = true

    lint.linters_by_ft = {
      -- lua = { "selene" },
      -- python = { "flake8" },
      -- vue = {"eslint"},
      -- typescript = {"eslint_d"},
      -- javascript = {"eslint_d"}
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }, {
      group = lint_augroup,
      callback = function()
        if lint_enabled then
          require("lint").try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>ul", function()
      lint_enabled = not lint_enabled
      diagnostic_enabled = not diagnostic_enabled

      if lint_enabled then
        require("lint").try_lint()
        vim.notify("Linting enabled", vim.log.levels.INFO)
      else
        vim.notify("Linting disabled", vim.log.levels.INFO)
      end

      vim.diagnostic.enable(not vim.diagnostic.is_enabled())

    end, { desc = "toggle [l]inting and diagnostics" })

    vim.api.nvim_create_user_command("LintInfo", function()
      local filetype = vim.bo.filetype
      local linters = require("lint").linters_by_ft[filetype]

      if linters then
        print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
      else
        print("No linters configured for filetype: " .. filetype)
      end
    end, {})
  end,
}
