vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.virtualedit = "block"

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Show the mode on bottom bar. We don't want this because it's already on status bar
vim.opt.showmode = false

vim.opt.undofile = true

-- Case insensitive searching. Use \C to or a capital letter to be case sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

-- Write to swap file every 1 second
vim.opt.updatetime = 1000

-- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = false

-- Preview substitions with `:s` live
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.wrap = false

vim.opt.scrolloff = 6

vim.opt.laststatus = 3

vim.opt.textwidth = 80

vim.opt.formatoptions:append("ron")

vim.api.nvim_create_autocmd('TextYankPost',
    {
        desc = "Highlight when yanking text",
        group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
        callback = function()
            vim.highlight.on_yank()
        end,
    })
