return {
    'hrsh7th/nvim-cmp', -- https://github.com/hrsh7th/nvim-cmp
    event = 'InsertEnter',
    dependencies = {
        {
            -- https://github.com/L3MON4D3/LuaSnip
            'L3MON4D3/LuaSnip',
            build = 'make install_jsregexp',
        },
        'saadparwaiz1/cmp_luasnip', -- https://github.com/saadparwaiz1/cmp_luasnip
        'hrsh7th/cmp-nvim-lsp',     -- https://github.com/hrsh7th/cmp-nvim-lsp
        'hrsh7th/cmp-path',         -- https://github.com/hrsh7th/cmp-path
        'onsails/lspkind.nvim',     -- https://github.com/onsails/lspkind.nvim
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('custom.cmp')
    end
}
