return {
    {
        dir = "~/projects/notes-nvim",
        priority = 0,
        config = function ()
            print(vim.fn.getcwd(), vim.fn.expand("~/vault"))
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
