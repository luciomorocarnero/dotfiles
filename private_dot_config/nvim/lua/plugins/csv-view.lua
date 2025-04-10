return {
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
    -- Configuración directa de las opciones de CsvView
    delimiter = ",",
    quote_char = "'",
    comment = "#",
    display_mode = "border",
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.csv",
      callback = function()
        print("Habilitar csv")
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count <= 200 then
            vim.cmd("CsvViewEnable")
        end
      end,
    })
  end,
}
