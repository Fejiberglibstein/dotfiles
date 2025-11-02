return {
    {
        "sainnhe/sonokai",
        priority = 1000,
        name = 'sonokai',
        opts = {

        },

        config = function(_, opts)
            vim.cmd'let g:sonokai_transparent_background = 2'
            vim.cmd'let g:sonokai_style = "andromeda"'
            -- vim.cmd.colorscheme "sonokai"
        end
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        name = 'nightfox',
        opts = {
            options = {
                transparent = true,
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)
            vim.cmd.colorscheme "nordfox"
        end,
    },
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
            -- vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        name = 'tokyonight',
        --- @type tokyonight.Config
        opts = {
            -- transparent = true,
            style = "night",
            -- dim_inactive = true,
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            -- vim.cmd.colorscheme "tokyonight"
        end
    }
}
