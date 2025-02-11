return {
  "akinsho/toggleterm.nvim",
  version = "*", -- O especifica una versión si lo prefieres
  config = function()
    require("toggleterm").setup({
      size = 20, -- Tamaño de la terminal al abrirla
      open_mapping = [[<c-\>]], -- Combinación de teclas para abrir la terminal
      shade_filetypes = {},
      shading_factor = 2, -- Intensidad del sombreado en la terminal
      start_in_insert = true, -- Iniciar en modo insert al abrir
      insert_mappings = true, -- Habilitar mapeos en modo insert
      auto_scroll = true,
      terminal_mappings = true, -- Habilitar mapeos en terminal
      persist_size = true, -- Recordar el tamaño de la terminal
      direction = "float", -- Dirección de la terminal ('horizontal', 'vertical', 'tab')
      close_on_exit = true, -- Cerrar la terminal al salir
    })
  end,
}
