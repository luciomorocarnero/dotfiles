-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local config
vim.opt.exrc = true

vim.g.have_nerd_font = true
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"

-- [[ Setting options ]]
-- See `:help vim.opt`
-- You can change these options as you wish!
-- Make line numbers default

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = "a"

vim.api.nvim_create_user_command("W", "w", { nargs = 0 })

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.filetype.add({
  extension = {
    astro = "astro",
    typst = "typst",
    html = "html",
    txt = "txt",
  },
})
