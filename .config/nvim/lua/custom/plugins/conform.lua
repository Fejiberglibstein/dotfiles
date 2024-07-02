return {
    'stevearc/conform.nvim',
    cmd = "W",
    config = function()
        -- Add :W which formats on save
        vim.api.nvim_create_user_command('W', function(_)
            require('conform').format({
                    async = true,
                    lsp_format = "fallback"
                }, function()
                    vim.cmd 'w'
                end)
        end, {})
    end
}
