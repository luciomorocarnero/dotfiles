return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip").setup({
          history = true,
          updateevents = "TextChanged,TextChangedI",
          enable_autosnippets = true,
        })
        -- Load friendly-snippets (predefined snippets for many languages)
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "roginfarrer/cmp-css-variables",
    "amarakon/nvim-cmp-fonts",
    "kristijanhusak/vim-dadbod-completion",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local compare = require("cmp.config.compare")

    -- Optional: Add icons to completion menu (requires nerd font or similar)
    local kind_icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    }

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup({
      -- ===== SNIPPETS =====
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- ===== KEYMAPS =====
      mapping = cmp.mapping.preset.insert({
        -- Scroll docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Show completion menu
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Close completion menu
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm selection
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false, -- Do not auto-select first item
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Navigate to next/previous placeholder in snippet
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),

      -- ===== FORMATTING =====
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Add icons to kinds
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
          -- Add source name in menu
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[Sig]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
            css_variables = "[CSS]",
            fonts = "[Font]",
          })[entry.source.name] or entry.source.name
          return vim_item
        end,
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
        { name = "nvim_lsp_document_symbol" },
        { name = "css_variables" },
        { name = "fonts", keyword_length = 5 },
      }, {}),

      -- ===== SORTING =====
      sorting = {
        priority_weight = 2,
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },

      -- ===== WINDOW =====
      window = {
        completion = {
          border = "rounded", -- "single", "double", "rounded", "solid", "shadow", "none"
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          scrollbar = true,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          max_width = 80,
          max_height = 20,
        },
      },

      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens", -- or "Comment"
        },
      },
    })

    -- ===== CMDLINE SETUP =====
    -- Use cmdline & path source for ':' (commands, variables, filenames)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    -- Use buffer source for '/' (search)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- For `?` (backwards search) you may want the same as `/`
    cmp.setup.cmdline("?", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
  end,
}
