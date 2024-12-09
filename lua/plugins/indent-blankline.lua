return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        -- char = "│", -- Default vertical line
        char = "┃", -- Thicker line
      },
      scope = {
        enabled = true, -- Disable context highlighting
        show_start = true, -- Show where the context starts
        show_end = false, -- Hide here the context ends
      },
      exclude = {
        filetypes = { "help", "lazy", "dashboard", "NvimTree", "Trouble" }, -- Ignore these buffers
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
}
