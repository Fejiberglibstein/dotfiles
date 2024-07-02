local cmp = require('cmp')
local luasnip = require('luasnip')
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
        -- Select the next item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the prev item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window backwards and forwards
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),

        -- Accept the completion
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),

        -- Move forward in the snippet expansion
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),
        -- Move backward in snippet expansion
        ['<C-h>'] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),
        -- For more luasnip keymaps, look at
        --  https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }
})
