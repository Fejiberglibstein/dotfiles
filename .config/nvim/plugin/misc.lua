vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

function Tabs(tabs)
	tabs = tabs or 4
	vim.opt.shiftwidth = tabs
	vim.opt.tabstop = tabs
	vim.opt.expandtab = true
end
Tabs()

