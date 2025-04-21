return {
  -- Colorscheme
  {
    "rebelot/kanagawa.nvim",
    --lazy = "false",
    name = "colorscheme-kanagawa",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme kanagawa-wave")
      -- vim.cmd("colorscheme kanagawa-lotus")
      -- vim.cmd("colorscheme kanagawa-dragon")
      require("kanagawa").load("wave")
    end,
  },

  -- Centered
  {
    "arnamak/stay-centered.nvim",
    lazy = false,
    opts = {
      skip_filetypes = {},
    },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- UndoTree
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>cu", "<cmd>lua require('undotree').toggle()<cr>", desc = "🌳 Undotree" },
    },
  },

  -- TSContext (ui)
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      vim.keymap.set("n", "<leader>uc", "<cmd>TSContextToggle<cr>", { desc = "toggle TS[c]ontext" })
    end,
  },

  -- Colors
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup({})
      require("cmp").setup({
        formatting = {
          format = require("nvim-highlight-colors").format,
        },
      })
      vim.keymap.set("n", "<leader>uh", "<cmd>HighlightColors Toggle<cr>", { desc = "toggle [h]ighlight colors" })
    end,
  },

  -- Icons Picker
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })

      local opts = { noremap = true, silent = true, desc = "😀 Pick Emoji" }

      vim.keymap.set("n", "<Leader>ci", "<cmd>IconPickerNormal emoji nerd_font_v3<cr>", opts)
      -- vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      -- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
    end,
  },

  -- Smouth Scroll
  -- {
  --   "karb94/neoscroll.nvim",
  --   opts = {},
  -- },
  {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },
  -- Extras
  { "tpope/vim-sleuth" },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
  },
  -- Vue Highlight
  {
    "posva/vim-vue",
  },
}
