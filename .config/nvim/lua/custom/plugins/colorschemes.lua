return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "macchiato",
            show_end_of_buffer = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15
            },
            config = function()
                vim.cmd.colorscheme "catppuccin"
                vim.cmd 'highlight Normal guibg=Transparent'
            end
        }
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = true
    }
}
