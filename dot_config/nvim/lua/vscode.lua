-- Bugs in vscode-neovim
--  * `j` and `k` opens folds (use `gj` and `gk`)
--  * typing is not perfectly synced
--  * loses visual mode selection with ':move'

local g = vim.g
local o = vim.o
local map = vim.keymap.set
local notify = vim.fn.VSCodeNotify

---@param cmd string
---@return function
local function action(cmd)
    return function()
        return notify(cmd)
    end
end

-- Settings
g.mapleader = ' '
g.maplocalleader = ' '
o.clipboard = 'unnamedplus'
-- TODO: play around with these to get the sweet spot for gcc commenting
o.timeoutlen = 100
o.updatetime = 100
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- Keybindings
-- NOTE: Insert mode keybindings are controlled by vscode
map('n', '0', '^')
map('n', '<leader>o', 'o<ESC>')
map('n', '<leader>O', 'O<ESC>')
-- dont like
-- map('n', '<C-j>', '<CMD>move .+1<CR>')
-- map('n', '<C-k>', '<CMD>move .-2<CR>')
-- map('x', '<C-j>', ":move '>+1<CR>gv=gv")
-- map('x', '<C-k>', ":move '<-2<CR>gv=gv")
--
-- map({ 'n', 'x' }, '<leader>w', action('workbench.action.files.save'))
-- map({ 'n', 'x' }, '<leader>W', action('workbench.action.files.saveAll'))
-- map('n', '<leader>q', action('workbench.action.closeActiveEditor'))
-- map('n', '<leader>[', action('workbench.action.previousEditor'))
-- map('n', '<leader>]', action('workbench.action.nextEditor'))

-- Commenting
-- BUG: doesn't work when the key combination is pressed too slowly (currently <100 ms as set above)
map('n', 'gcc', '<Plug>VSCodeCommentaryLine') -- TODO: try adding a <CR>?
map({ 'n', 'x', 'o' }, 'gc', '<Plug>VSCodeCommentary')

-- Folds
map('n', 'za', action('editor.toggleFold'))
map('n', 'zo', action('editor.toggleFold'))

-- Window navigations
map({ 'n', 'x' }, '<C-h>', action('workbench.action.focusLeftGroup'))
map({ 'n', 'x' }, '<C-j>', action('workbench.action.focusBelowGroup'))
map({ 'n', 'x' }, '<C-k>', action('workbench.action.focusAboveGroup'))
map({ 'n', 'x' }, '<C-l>', action('workbench.action.focusRightGroup'))

-- Code navigations
map({ 'n', 'x' }, 'gr', action('editor.action.goToReferences'))
-- example: map({ 'n', 'x', 'o' }, 'gc', '<Plug>VSCodeCommentary')
map({ 'n', 'x', 'o' }, '<leader>', action('vspacecode.space'))
map({ 'n', 'x', 'o' }, '<C-p>', action('vspacecode.space'))
-- example map('n', '<leader>q', action('workbench.action.closeActiveEditor'))

-- Autocommands
local num_au = vim.api.nvim_create_augroup('NUMTOSTR', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        -- BUG: not working in vscode
        vim.highlight.on_yank({ higroup = 'Visual' })
    end,
})

return require('packer').startup({
    function(use)
        -- TODO
        -- * vim-surround
        -- * gitsigns keybindings
        -- * lsp+diagnostics keybindings

        use({
            'phaazon/hop.nvim',
            event = 'BufRead',
            config = function()
                require('hop').setup()
                map('n', '<S-j>', '<CMD>HopWordAC<CR>')
                map('n', '<S-k>', '<CMD>HopWordBC<CR>')
            end,
        })

        -- This is Buggy
        -- use({
        --     'tpope/vim-surround',
        --     event = 'BufRead',
        --     requires = {
        --         {
        --             'tpope/vim-repeat',
        --             event = 'BufRead',
        --         },
        --     },
        -- })
    end,
})
