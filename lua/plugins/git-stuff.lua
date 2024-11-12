return {
  {
    "tpope/vim-fugitive",
  },
  {
    "dinhhuy258/git.nvim",
    config = function()
      require("git").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      require("config/options/gitsigns")
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
