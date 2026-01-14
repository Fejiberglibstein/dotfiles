vim.bo.commentstring = "// %s"
vim.opt.colorcolumn = "101"
vim.opt.textwidth = 100


-- vim.keymap.set('n', '<leader>hf', [[][%?^\w<CR>"my/{<CR>[]%?^\w<CR>"lyy:LspClangdSwitchSourceHeader<CR>"mp]])

vim.filetype.add({
	extension = {
		h = 'c'
	}
})
