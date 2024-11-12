return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    require("config/options/obsidian")
  end,
  config = function(_, opts)
    require("obsidian").setup(opts)
  end,
}
