require("full-border"):setup()
-- require("wl-clipboard"):setup()

require("bunny"):setup({
  hops = {
    { key = "/",          path = "/",                                    },
    { key = "~",          path = "~",              desc = "Home"         },
    { key = "D",          path = "~/Documents",    desc = "Documents"    },
    { key = "d",          path = "~/Downloads",      desc = "Downloads"      },
    -- { key = "t",          path = "/tmp",                                 },
    -- { key = "m",          path = "~/Music",        desc = "Music"        },
    -- { key = "c",          path = "~/.config",      desc = "Config files" },
    -- { key = { "l", "s" }, path = "~/.local/share", desc = "Local share"  },
    -- { key = { "l", "b" }, path = "~/.local/bin",   desc = "Local bin"    },
    -- { key = { "l", "t" }, path = "~/.local/state", desc = "Local state"  },
    -- key and path attributes are required, desc is optional
  },
  desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
  ephemeral = true, -- Enable ephemeral hops, default is true
  tabs = true, -- Enable tab hops, default is true
  notify = false, -- Notify after hopping, default is false
  fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})
