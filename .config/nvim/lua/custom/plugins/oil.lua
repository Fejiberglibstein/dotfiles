return {
    'stevearc/oil.nvim', -- https://github.com/stevearc/oil.nvim
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function(_, opts)
        require('oil').setup(opts)

        vim.keymap.set('n', '<leader>ft', function()
            require('oil').open()
        end, { desc = 'Open file directory' })

        vim.keymap.set('n', '<leader><leader>ft', function()
            require('oil').open(vim.fn.getcwd())
        end, { desc = 'Open parent directory' })

        -- Make keymap q to close window
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("Oil-q-close", { clear = true }),
            callback = function()
                if not require('oil.util').is_oil_bufnr(0) then
                    return
                end
                -- We need to close the buffer but not the window.
                -- So, we can just go back to the previous buffer
                vim.api.nvim_set_keymap('n', 'q', '<CMD>b#<CR>', {})
            end
        })

        vim.api.nvim_create_autocmd("BufLeave", {
            callback = function()
                -- Remove the keymap when the oil buffer is closed
                if not require('oil.util').is_oil_bufnr(0) then
                    return
                end
                vim.api.nvim_del_keymap('n', 'q')
            end
        })
    end
}
