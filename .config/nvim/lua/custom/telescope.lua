require('telescope').setup()
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Search Help" })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = "Search Files" })
vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = "Search Resume" })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = "Search Diagnostics" })

vim.keymap.set('n', '<leader>sc', function()
    builtin.find_files { cwd = vim.fn.stdpath('config') }
end, { desc = "Search Config" })

vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', 'z=', builtin.spell_suggest);
