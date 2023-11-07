-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local M = {
  -- buffers
  vim.keymap.set("n", "<leader>bc", require("mini.bufremove").delete, { desc = "Delete buffer" }),
  vim.keymap.set("n", "<leader>bk", require("mini.bufremove").delete, { desc = "Delete buffer" }),
  vim.keymap.set({ "n", "i" }, "<A-w>", require("mini.bufremove").delete, { desc = "Delete buffer" }),
  vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Show Buffers" }),

  vim.keymap.set("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>"),
  vim.keymap.set("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>"),
  -- annoying move line on alt-j/k
  vim.keymap.set({ "n", "i", "v" }, "<A-j>", "<nop>"),
  vim.keymap.set({ "n", "i", "v" }, "<A-k>", "<nop>"),

  vim.keymap.set("i", "jk", "<Esc><cr>"),
  vim.keymap.set("i", "kj", "<Esc><cr>"),

  vim.keymap.set("n", "<c-\\>", require("lazyvim.util").terminal.open, { desc = "Terminal (root dir)" }),
  vim.keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" }),

  -- Paste without replace clipboard
  vim.keymap.set("v", "p", '"_dP'),

  -- BUG: Fix for the weird "n" behaviour.... however I am quite sure I introduced this bug by set setting "n" in keys somewhere...
  -- TODO: find the culprit
  vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" }),
  vim.keymap.set({ "o", "x" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" }),
}
return M
