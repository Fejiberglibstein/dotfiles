return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = true,
        --- @type CatppuccinOptions
        opts = {
            integrations = {
                cmp = true
            },
            flavour = "macchiato",

            show_end_of_buffer = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15
            },
            transparent_background = true
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        name = 'tokyonight',
        --- @type tokyonight.Config
        opts = {
            transparent = true,
            style = "night",
            -- dim_inactive = true,
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            -- vim.cmd.colorscheme "tokyonight"
        end
    }
}
