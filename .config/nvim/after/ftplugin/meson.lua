vim.keymap.set(
	'n',
	'<leader>fl',
	[[vi[:!find src/ -name "*.c" | grep -v "main.c" | sort | xargs -I{} echo "'{}'",=i[]],
	{ buffer = true }
)
