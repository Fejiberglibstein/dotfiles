vim.bo.commentstring = "// %s"

-- this doesn't work lol
-- trying to make header files have a filetype of c

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
-- 	-- pattern = { "*.h", "*.c" },
-- 	group = vim.api.nvim_create_augroup("hwuverhiuuw", {}),
-- 	callback = function()
-- 		print("hi")
-- 		-- vim.bo.filetype = "c"
-- 	end
-- })
