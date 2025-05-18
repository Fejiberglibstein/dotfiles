vim.bo.commentstring = "; %s"
vim.bo.comments      = "b:;,b:;;"
vim.opt.colorcolumn  = "81"
vim.opt.updatetime   = 250

vim.keymap.set(
	'n',
	'<leader>r',
	[[:s/\s*.ref \(.*\)/P\1: .word \1<cr>:noh<cr>]],
	{ buffer = true }
)


-- Highlighting lines when you hover over a register
local ns   = vim.api.nvim_create_namespace("RegHL")
local mark = nil

local function clear_mark()
	if mark then
		vim.api.nvim_buf_del_extmark(0, ns, mark)
	end
end

local function get_reg_assignment()
	clear_mark()

	-- make sure that we are on a register (starts with r)
	local reg = vim.fn.expand("<cWORD>")
	if reg:sub(1, 1) ~= "r" then
		return
	end
	reg = vim.fn.expand("<cword>")

	local line = vim.fn.line('.') - 1
	while true do
		local text = vim.fn.getline(line)

		-- Find the line that has a word followed by the register as the first
		-- argument
		--
		-- add r1, r2, r3
		-- (will look for r1)
		if text:find("^%s*%a+%s*" .. reg .. ".*") and not text:find("^%s*cmp") then
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
	{ buffer = true }
)

--------------------------------------------------------------------------------
-- Opening ccstudio and adding a build keymap
--------------------------------------------------------------------------------

if not Ccstudio_api_port then
	Ccstudio_api_port = 2035
end

local namespace = vim.api.nvim_create_namespace("ccstudio")

local function ccs_build()
	if Ccstudio_api_port == nil then
		print('ccstudio is not started yet')
		return
	end
	vim.diagnostic.reset(namespace)

	print('building')
	local res = require('plenary.job'):new({
		command = 'curl',
		args = { 'localhost:' .. Ccstudio_api_port .. '/ide/buildProjects' }
	}):sync();
	---@type {output: string}
	local json = vim.fn.json_decode(res)
	-- vim.print(json);

	local last_err_bufnr = nil

	---@type {number: vim.Diagnostic[]}
	local errors = {}
	for line in json['output']:gmatch("[^\r\n]+") do
		local filename, severity, line_num, message = line:match('^%s*%"(.*)%", (.*)! %s* at line (%d+): (.*)$')
		if filename == nil and last_err_bufnr ~= nil then
			-- Update the last error to include the new line
			if #line > 2 then
				local buf_errors = errors[last_err_bufnr]
				buf_errors[#buf_errors].message = buf_errors[#buf_errors].message .. "\n" .. line
			else
				last_err_bufnr = nil
			end
		end
		if filename ~= nil then
			--- @cast filename string
			filename = filename:sub(4)
			local file = vim.fn.findfile(filename)

			local bufnr = vim.fn.bufnr(file)
			if bufnr == -1 then
				vim.cmd('edit ' .. filename)
				bufnr = vim.fn.bufnr(filename)
			end

			last_err_bufnr = bufnr

			if not errors[bufnr] then
				errors[bufnr] = {}
			end

			errors[bufnr][#errors[bufnr] + 1] = {
				message = message,
				---@type number?
				lnum = tonumber(line_num) - 1,
				severity = "ERROR",
				col = 1,
				bufnr = tonumber(bufnr) or 0,
			}
		end
	end

	for bufnr, error in pairs(errors) do
		vim.diagnostic.set(namespace, bufnr, error)
	end
end

-- local function ccs_start()
-- 	if Ccstudio ~= nil then
-- 		return
-- 	end
--
-- 	print("starting ccstudio...")
--
-- 	Ccstudio = require 'plenary.job':new({
-- 		command = '/home/austint/ti/ccs1280/ccs/eclipse/ccstudio',
-- 		on_exit = function()
-- 			print('ccstudio exited')
-- 			Ccstudio = nil
-- 			Ccstudio_api_port = nil
-- 		end,
-- 		on_stdout = function(error, data, self)
-- 			local res = data:match('^CCS HTTP adapter started! %[ccs.port:(%d+)%]')
-- 			if res ~= nil then
-- 				print('CCS HTTP adapter was started on port' .. res)
-- 				Ccstudio_api_port = res
-- 				return
-- 			end
-- 		end
-- 	})
--
-- 	Ccstudio:start()
-- end

vim.keymap.set('n', '<leader><leader>b', function()
	if Ccstudio_api_port == nil then
	end
	ccs_build()
end)
