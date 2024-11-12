local options = {
  workspaces = {
    {
      name = "DEV",
      path = "/Volumes/casa-main-share/dominick/Obsidian/Dev",
    },
  },
  notes_subdir = "Main Notes",
  new_notes_location = "notes_subdir",
  disable_frontmatter = true,
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M:%S",
  },
  mappings = {
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
}

return options