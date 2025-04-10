return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "g,", -- set to `false` to disable one of the mappings
            node_incremental = "gm",
            scope_incremental = false,
            node_decremental = "gn",
          },
        },
      })
    end,
  },
}

