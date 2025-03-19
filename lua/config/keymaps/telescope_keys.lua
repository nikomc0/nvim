local M = {}
local builtin = require("telescope.builtin")

M.telescope = {
  -- Find Files
  {
    "<leader>fp",
    function()
      builtin.find_files({
        cwd = require("lazy.core.config").options.root,
      })
    end,
    desc = "Find Plugin File",
  },

  -- Find recent files
  {
    "<leader>fr",
    function()
      builtin.oldfiles({
        only_cwd = true,
      })
    end,
    desc = "Find recent files",
  },

  -- Find string in cwd
  {
    "<leader>lg",
    function()
      builtin.live_grep()
    end,
  },

  -- Find string under cursor in cwd
  {
    "<leader>fc",
    function()
      builtin.grep_string()
    end,
  },
}

return M
