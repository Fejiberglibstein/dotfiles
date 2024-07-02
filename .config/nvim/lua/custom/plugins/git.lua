return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        cmd = "Neogit",
        opts = {
            graph_style = "unicode"

        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Hunk staging and resetting
                map('n', '<leader>hs', gitsigns.stage_hunk, {desc = "[Git] Stage hunk"})
                map('n', '<leader>hr', gitsigns.reset_hunk)
                map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

                -- Undo staging and resetting
                map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "[Git] Undo stage hunk"})
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[Git] Preview hunk"})

            end
        },

    }
}
