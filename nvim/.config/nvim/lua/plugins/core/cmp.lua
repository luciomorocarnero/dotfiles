return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" }, -- Carga cuando se necesita
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "roginfarrer/cmp-css-variables",
    "amarakon/nvim-cmp-fonts",
    -- Separamos LuaSnip para que su build sea replicable
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp", -- Esto compila la librería localmente
      dependencies = { "rafamadriz/friendly-snippets" }, -- Replicable en cualquier lado
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Cargar snippets de VSCode (de friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Tus filtros personalizados (Field, Function, Variable)
    local filters = function(field)
      return cmp.mapping.complete({
        config = {
          sources = {
            {
              name = "nvim_lsp",
              entry_filter = function(entry)
                local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
                return kind == field
              end,
            },
          },
        },
      })
    end

    -- Configuración de nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
        -- Mapeos de tus filtros
        ["<M-f>"] = filters("Field"),
        ["<M-F>"] = filters("Function"),
        ["<M-v>"] = filters("Variable"),
      }),
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "css-variables" },
        { name = "fonts", option = { space_filter = "-" } },
      }),
    })

    -- Configuración para la línea de comandos (:)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
      }),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
      completion = {
        completeopt = "menu,menuone,noselect",
      },
    })
  end,
}
