return {
  {
    "rhysd/vim-grammarous",
    init = function()
      vim.g["grammarous#jar_url"] = "https://www.languagetool.org/download/archive/LanguageTool-5.9.zip"
    end,
  },
  {
    "junegunn/limelight.vim",
  },
  {
    "preservim/vim-pencil",
    init = function()
      vim.g["pencil#wrapModeDefault"] = "soft"
    end,
  },
}
