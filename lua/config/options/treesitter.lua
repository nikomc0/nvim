local options = {
  ensure_installed = { "lua", "go", "javascript", "typescript", "html" },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  indent = { enable = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  context_commentstring = {
    enable = false,
    enable_autocmd = false,
  },

  autotag = { enable = true },
}

return options
