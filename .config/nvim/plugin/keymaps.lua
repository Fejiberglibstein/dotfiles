-- Press escape to turn off search coloring
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', "<CMD>nohlsearch<CR>")

-- Terminal exit terminal mode
vim.keymap.set('t', '<ESC><ESC>', "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keymaps for J and K in visual mode
vim.keymap.set('v', 'J', function()
    local count = math.max(vim.v.count, 1)
    return ":m '>+" .. count .. "<CR>gv=gv"
end, { expr = true, desc = "Move selected lines down when in visual mode" })

vim.keymap.set('v', 'K', function()
    local count = math.max(vim.v.count, 1)
    return ":m '<-" .. count + 1 .. "<CR>gv=gv"
end, { expr = true, desc = "Move selected lines up when in visual mode" })

-- Command mode moving around
vim.keymap.set('c', '<c-b>', '<left>');
vim.keymap.set('c', '<c-f>', '<right>');

vim.keymap.set('c', '<a-b>', '<s-left>');
vim.keymap.set('c', '<a-f>', '<s-right>');


-- nicer window nav, matches what I have in tmux
vim.keymap.set('n', '<c-w><c-h>', '<c-w>h')
vim.keymap.set('n', '<c-w><c-l>', '<c-w>l')
vim.keymap.set('n', '<c-w><c-j>', '<c-w>j')
vim.keymap.set('n', '<c-w><c-k>', '<c-w>k')

vim.keymap.set('n', '<c-w>l', '<c-w><')
vim.keymap.set('n', '<c-w>l', '<c-w>>')
vim.keymap.set('n', '<c-w>j', '<c-w>+')
vim.keymap.set('n', '<c-w>k', '<c-w>-')


-- When pressing J keep cursor in same spot
vim.keymap.set('n', 'J', "mzJ`z")

-- Put S copy into null register
vim.keymap.set('n', 'S', '"_S');

-- Nicer motions for deleting paragraphs
vim.keymap.set('o', '{', 'V{', { nowait = true });
vim.keymap.set('o', '}', 'V}', { nowait = true });

-- Make jump list nicer
--
-- Make j/k add a jumplist position when the count is > 8
local function remap_jk(key)
    vim.keymap.set('n', key, function()
        if vim.v.count > 8 then
            return 'm\'' .. vim.v.count .. key
        else
            return key
        end
    end, { expr = true });
end

remap_jk('j')
remap_jk('k')

vim.keymap.set('n', '<c-d>', '<c-d>zz');
vim.keymap.set('n', '<c-u>', '<c-u>zz');

-- -- Make it so doing ctrl-u/d will add the starting position when you initially ctrl u/d to the jump list. If you move the cursor inbetween ctrl-u/d presses, it will change the jumpoint
-- local cursor_moved = false
-- local function cursor_moved_fn(callback)
-- vim.api.nvim_create_autocmd('CursorMoved', {
-- group = vim.api.nvim_create_augroup('<C-d> and <C-u> fix', { clear = true }),
-- callback = callback
-- })
-- end
--
-- local function remap_ctrl_ud(key)
-- vim.keymap.set('n', key, function()
-- -- cursor_moved_fn's autocmd runs whenever the cursor moves. When this remap_ctrl_ud function returns,
-- cursor_moved_fn(function()
-- cursor_moved_fn(function()
-- cursor_moved = true
-- end)
-- end)
-- key = key .. 'zz'
-- if cursor_moved == false then
-- return key
-- else
-- cursor_moved = false
-- return 'm\'' .. key
-- end
-- end, { expr = true })
-- end
--
-- remap_ctrl_ud('<C-u>')
-- remap_ctrl_ud('<C-d>')
--
-- cursor_moved_fn(function()
-- cursor_moved = true
-- end)
