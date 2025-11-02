vim.bo.commentstring = "# %s"
vim.bo.comments      = "b:#,b:##"
vim.bo.syntax        = "asm"
vim.opt.colorcolumn  = "81"
vim.opt.updatetime = 250

local ns = vim.api.nvim_create_namespace("RegHL")
local mark = nil

local function clear_mark()
	if mark then
		vim.api.nvim_buf_del_extmark(0, ns, mark)
	end
end

local function get_reg_assignment()
	clear_mark()

	-- make sure that we are on a register (starts with $)
	local reg = vim.fn.expand("<cWORD>")
	if reg:sub(1, 1) ~= "$" then
		return
	end


	reg = vim.fn.expand("<cword>")

	local line = vim.fn.line('.') - 1
	while true do
		local text = vim.fn.getline(line)
		if text:find("^%s%a+%s%$" .. reg .. ".*") then
			break
		end
		line = line - 1

		if line <= -1 then
			return
		end
	end

	return line
end

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	group = vim.api.nvim_create_augroup("regMove", { clear = true }),
	buffer = 0,
	callback = clear_mark
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	group = vim.api.nvim_create_augroup("regHold", { clear = true }),
	buffer = 0,
	callback = function()
		local line = get_reg_assignment()
		if not line then
			return
		end
		mark = vim.api.nvim_buf_set_extmark(0, ns, line - 1, 0, {
			line_hl_group = 'ColorColumn'
		})
	end
})

vim.keymap.set('n', 'gd',
	function()
		local line = get_reg_assignment()
		if not line then
			return
		end
		vim.cmd("normal! m'")
		vim.cmd(tostring(line))
	end,
	{ buffer = true })
