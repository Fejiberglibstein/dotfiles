return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>u', function()
            vim.cmd.UndotreeFocus()
            vim.cmd.UndotreeShow()
        end, { desc = "Undo Tree" })
    end
}
