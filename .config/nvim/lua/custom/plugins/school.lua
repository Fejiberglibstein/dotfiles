return {
    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ft = { "markdown" },
        opts = {
            overrides = { buftype = { nofile = { enabled = false } } },
            code = {
                width = 'block',
                min_width = 80,
                left_pad = 1,
                style = "normal"
            },
            latex = { enabled = false },
            ft = { "markdown" },
            heading = {
                left_pad = 1,
                sign = false,
                border = true,
                width = 'block',
                min_width = 80,
            }
        },
    },
    { "jannis-baum/vivify.vim", },
    {
        dir = "~/projects/notes-nvim",
        priority = 0,
        config = function()
            -- print(vim.fn.getcwd(), vim.fn.expand("~/vault"))
            if vim.fn.getcwd() == vim.fn.expand("~/vault") then
                -- require('notes-nvim').setup()
            end
        end
    },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        dependencies = { "lervag/vimtex", "L3MON4D3/LuaSnip" },
        ft = { "tex" },
    },
    {
        "evesdropper/luasnip-latex-snippets.nvim",
        ft = { "tex" },
        dependencies = { "lervag/vimtex", "L3MON4D3/LuaSnip" },
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
            vim.api.nvim_create_autocmd("BufReadPre", {
                pattern = { "*.tex" },
                callback = function()
                    vim.b.vimtex_main = vim.api.nvim_buf_get_name(0)
                end
            })
        end
    }
}
