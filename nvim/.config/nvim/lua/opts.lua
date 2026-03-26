-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local config
vim.opt.exrc = true

vim.g.have_nerd_font = true
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
  vim.keymap.set({'n', 'v'}, 'd', '"_d')
  vim.keymap.set({'n', 'v'}, 'c', '"_c')
  vim.keymap.set('n', 'D', '"_D')
  vim.keymap.set('n', 'C', '"_C')
  vim.keymap.set('x', 'p', '"_dP')
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- -- Diagnostics
vim.diagnostic.config({ virtual_text = true  })

-- -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.formatprg = "par -w 100"

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- folding.lua

-- Nice and simple folding:


vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })



vim.filetype.add({
  extension = {
    astro = "astro",
    typst = "typst",
    html = "html",
    txt = "txt",
  },
})
