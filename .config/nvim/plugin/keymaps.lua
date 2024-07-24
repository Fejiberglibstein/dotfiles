-- Press escape to turn off search coloring
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', "<CMD>nohlsearch<CR>")

-- Diagnostic Keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic error message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open Diagnostic Quick Fix List" })

-- Terminal exit terminal mode Press escape to turn off search coloring
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

-- When pressing J keep cursor in same spot
vim.keymap.set('n', 'J', "mzJ`z")

-- Nicer motions for deleting paragraphs
vim.keymap.set('n', 'd{', '$d{x');
vim.keymap.set('n', 'd}', '0d}');

-- Source files
vim.keymap.set('n', '<leader><leader>x', "<CMD>source %<CR>", { desc = "Source file" });
vim.keymap.set('n', '<leader>x', "<CMD>. lua<CR>", { desc = "Source file" });


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

-- Make it so doing ctrl-u/d will add the starting position when you initially ctrl u/d to the jump list. If you move the cursor inbetween ctrl-u/d presses, it will change the jumpoint
local cursor_moved = false
local function cursor_moved_fn(callback)
    vim.api.nvim_create_autocmd('CursorMoved', {
        group = vim.api.nvim_create_augroup('<C-d> and <C-u> fix', { clear = true }),
        callback = callback
    })
end

local function remap_ctrl_ud(key)
    vim.keymap.set('n', key, function()
        -- cursor_moved_fn's autocmd runs whenever the cursor moves. When this remap_ctrl_ud function returns,
        cursor_moved_fn(function ()
            cursor_moved_fn(function ()
                cursor_moved = true
            end)
        end)
        key = key .. 'zz'
        if cursor_moved == false then
            return key
        else
            cursor_moved = false
            return 'm\'' .. key
        end
    end, { expr = true })
end

remap_ctrl_ud('<C-u>')
remap_ctrl_ud('<C-d>')

cursor_moved_fn(function ()
   cursor_moved = true
end)
