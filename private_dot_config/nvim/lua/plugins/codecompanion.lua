return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
      },
      adapters = {
        gemini = function()
          local api_key = vim.env.GEMINI_API_KEY
          if not api_key then
            vim.notify("GEMINI_API_KEY no está configurada.", vim.log.levels.ERROR)
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "",
              },
            })
          end
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = api_key,
            },
          })
        end,
      },
    })
    vim.keymap.set("n", "<leader>li", "<cmd>CodeCompanionActions<cr>", { desc = "Lazy AI" })
  end,
}
