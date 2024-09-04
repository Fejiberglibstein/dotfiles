return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
        require('nvim-autopairs').setup {}

        -- Automatically add () after autocompleting function
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'

        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        local Rule = require('nvim-autopairs.rule')
        local npairs = require('nvim-autopairs')
        local cond = require('nvim-autopairs.conds')

        npairs.add_rules({
                Rule("$", "$", { "tex", "latex" })
                -- don't add a pair if the next character is %
                    :with_pair(cond.not_after_regex("%%"))
                -- don't move right when repeat character
                    :with_move(cond.none())
                -- disable adding a newline when you press <cr>
                    :with_cr(cond.none())
            })

        npairs.add_rule(
            Rule("$$", "$$", "tex")
            :with_pair(cond.after_text("$"))
            :replace_endpair(function () return "$" end)
        )


        npairs.add_rule(
            Rule("$ ", " $", "tex")
            :with_pair(cond.after_text("$"))
            :replace_endpair(function () return " " end)
        )


    end
}
