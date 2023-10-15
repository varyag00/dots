-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end

-- NOTE: use vim.keymap.set
local M = {
  -- buffers
  vim.keymap.set("n", "<leader>bc", ":bdelete<cr>", { desc = "Delete buffer" }),
  vim.keymap.set("n", "<leader>bk", ":bdelete<cr>", { desc = "Delete buffer" }),
  vim.keymap.set({ "n", "i" }, "<A-w>", ":bdelete<cr>", { desc = "Delete buffer" }),
  vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>"),

  vim.keymap.set("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>"),
  vim.keymap.set("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>"),
  -- annoying move line on alt-j/k
  vim.keymap.set({ "n", "i", "v" }, "<A-j>", "<nop>"),
  vim.keymap.set({ "n", "i", "v" }, "<A-k>", "<nop>"),

  vim.keymap.set("i", "jk", "<Esc><cr>"),
  vim.keymap.set("i", "kj", "<Esc><cr>"),

  vim.keymap.set("n", "<c-\\>", lazyterm, { desc = "Terminal (root dir)" }),
  vim.keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" }),

  -- Paste without replace clipboard
  vim.keymap.set("v", "p", '"_dP'),
}
return M
