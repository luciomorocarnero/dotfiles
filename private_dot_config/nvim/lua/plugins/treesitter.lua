return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",       -- arranca selección con Enter (podés cambiarlo)
            node_incremental = ".",        -- aumentar rango
            node_decremental = ",",        -- disminuir rango
            scope_incremental = false,
          },
        },
      })
    end,
  },
}
