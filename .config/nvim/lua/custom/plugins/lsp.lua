return {
    -- LSP plugins
    "neovim/nvim-lspconfig", -- https://github.com/neovim/nvim-lspconfig
    dependencies = {
        -- https://github.com/williamboman/mason.nvim
        { 'williamboman/mason.nvim', config = true },

        -- https://github.com/williamboman/mason-lspconfig.nvim
        'williamboman/mason-lspconfig.nvim',

        -- https://github.com/j-hui/fidget.nvim
        {
            'j-hui/fidget.nvim',
            opts = {
                notification = {
                    window = {
                        -- For transparent background
                        winblend = 0,
                    }
                }
            }
        },

        -- https://github.com/folke/lazydev.nvim
        { 'folke/lazydev.nvim',      opts = {},    ft = 'lua' },

    },
    config = function()
        require("custom.lsp")
    end,
}
