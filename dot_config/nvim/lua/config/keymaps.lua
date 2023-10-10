-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local M = {
  -- buffers
  vim.keymap.set("n", "<leader>bc", ":bdelete<cr>"),
  vim.keymap.set("n", "<leader>bk", ":bdelete<cr>"),
  vim.keymap.set({ "n", "i" }, "<A-w>", ":bdelete<cr>"),
  vim.keymap.set("n", "<leader>bn", ":bdelete<cr>"),
  vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>"),

  vim.keymap.set("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>"),
  vim.keymap.set("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>"),

  vim.keymap.set("i", "jk", "<Esc><cr>"),
  -- use vim.keymap.set
}

return M
