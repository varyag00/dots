-- from https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim
-- https://github.com/numToStr/dotfiles/commit/0612c330422289b75999846fab733516c40c469b

vim.loader.enable()
if vim.g.vscode ~= nil then
    return require('vscode')
end
require('settings')
require('autocmd')
require('plugins')
require('keybinds')
