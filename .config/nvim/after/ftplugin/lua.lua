-- Source files
vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>x', "<CMD>source %<CR>", { desc = "Source file" });
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>x', "<CMD>. lua<CR>", { desc = "Source selection" });
vim.api.nvim_buf_set_keymap(0, 'v', '<leader>x', "<CMD>'<,'>lua<CR>", { desc = "Source selection" });

local function testFile()
	local current_buf = vim.api.nvim_buf_get_name(0)
	if current_buf:find('_spec.lua') then
		LastTestedFile = current_buf
	end
	assert(LastTestedFile, "You have not tested any file yet")

	return "<CMD>PlenaryBustedFile " .. LastTestedFile .. "<CR>"
end

vim.keymap.set('n', '<leader>t', testFile, { desc = "Test with plenary", buffer = true, expr = true })
vim.keymap.set('n', '<leader><leader>t', "<CMD>PlenaryBustedDirectory tests/<CR>", {
	desc = "Test with plenary",
	buffer = true
})
