return {
  "matze/vim-move",
  init = function()
    vim.g.move_map_keys = 0
  end,
  config = function()
    vim.keymap.set('n', '<A-j>', '<Plug>MoveLineDown', { silent = true })
    vim.keymap.set('n', '<A-k>', '<Plug>MoveLineUp', { silent = true })
    vim.keymap.set('v', '<A-j>', '<Plug>MoveBlockDown', { silent = true })
    vim.keymap.set('v', '<A-k>', '<Plug>MoveBlockUp', { silent = true })
  end
}
