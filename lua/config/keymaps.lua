-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Moves line up or down
vim.keymap.set("n", "<C-j>", ":m .-2<CR>==") -- Move single line up
vim.keymap.set("n", "<C-k>", ":m .+1<CR>==") -- Move single line down

-- Moves multiple lines up or down
vim.keymap.set("v", "<C-k>", ":m '>+1<CR>gv=gv") -- Move selection down
vim.keymap.set("v", "<C-j>", ":m '<-2<CR>gv=gv") -- Move selection up

-- Switch between tabs
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")

-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
