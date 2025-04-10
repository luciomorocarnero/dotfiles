return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  build = (function()
    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
      return
    end
    return "make install_jsregexp"
  end)(),
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Configuración de LuaSnip
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Configuración de CMP
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
      }),
      sources = cmp.config.sources({
        {
          name = "lazydev",
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      completion = { completeopt = "menu,menuone,noinsert" },
    })

    -- Configuración de CMP para cmdline
    -- cmp.setup.cmdline("/", {
    --   mapping = cmp.mapping.preset.cmdline({
    --     ["<Up>"] = cmp.mapping.select_prev_item(),
    --     ["<Down>"] = cmp.mapping.select_next_item(),
    --     ["<Space>"] = cmp.mapping.confirm({ select = true }),
    --   }),
    --   sources = cmp.config.sources({
    --     { name = "buffer" },
    --   }),
    -- })
    --
    -- cmp.setup.cmdline("t", {
    --   mapping = cmp.mapping.preset.cmdline({
    --     ["<Up>"] = cmp.mapping.select_prev_item(),
    --     ["<Down>"] = cmp.mapping.select_next_item(),
    --     ["<Space>"] = cmp.mapping.confirm({ select = true }),
    --   }),
    --   sources = cmp.config.sources({
    --     { name = "buffer" },
    --   }),
    -- })
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline({
    --     ["<Up>"] = cmp.mapping.select_prev_item(),
    --     ["<Down>"] = cmp.mapping.select_next_item(),
    --     ["<Space>"] = cmp.mapping.confirm({ select = true }),
    --   }),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --     { name = "cmdline" },
    --   }),
    -- })
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline({
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "c" }),
        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "c" }),
      }),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "c" }),
        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "c" }),
      }),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
