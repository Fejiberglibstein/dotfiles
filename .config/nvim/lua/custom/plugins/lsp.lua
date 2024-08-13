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
        {
            'folke/lazydev.nvim',
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
            ft = 'lua',
            -- https://github.com/Bilal2453/luvit-meta
            dependencies = { "Bilal2453/luvit-meta", lazy = true } -- Bindings for vim.uv
        },

    },
    config = function()
        require("custom.lsp")
    end,
}
