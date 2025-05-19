vim.opt_local.commentstring = "// %s"
vim.opt.colorcolumn         = "81"
vim.opt.spell                = true
vim.opt.shiftwidth           = 2
vim.opt.tabstop              = 2
-- Make `+` be formatted as a list
vim.opt_local.formatlistpat = [[^\s*\(\(\d\+[\]:.)}\t ]\)\|\(+\)\|\(-\)\)\s*]]

-- Autopairs

local Rule                  = require('nvim-autopairs.rule')
local npairs                = require('nvim-autopairs')
local cond                  = require('nvim-autopairs.conds')

npairs.clear_rules()
require('nvim-autopairs').setup {}

-- Automatically add () after autocompleting function
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'

npairs.add_rules({
	Rule("$", "$", { "typst" })
	-- :with_pair(cond.not_after_regex("%%"))
	-- don't move right when repeat character
		:with_move(cond.invert(cond.none()))
	-- disable adding a newline when you press <cr>
	-- :with_cr(cond.none())
})

npairs.add_rule(
	Rule("$ ", " $", { "typst", })
	:with_pair(cond.after_text("$"))
	:replace_endpair(function() return " " end)
)
