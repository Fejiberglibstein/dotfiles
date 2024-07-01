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

-- Nicer ctrl d and ctrl u
vim.keymap.set('n', '<C-d>', "<C-d>zz");
vim.keymap.set('n', '<C-u>', "<C-u>zz");

-- When pressing J keep cursor in same spot
vim.keymap.set('n', 'J', "mzJ`z")

vim.keymap.set('n', '<leader><leader>x', "<CMD>source %<CR>", { desc = "Source file" });
vim.keymap.set('n', '<leader>x', "<CMD>. lua<CR>", { desc = "Source file" });
