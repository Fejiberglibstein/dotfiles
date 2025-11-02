-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { "*.hl", "hypr*.conf" },
    callback = function(event)
        vim.lsp.start {
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
        }
    end
})

return {
    {
        "elkowar/yuck.vim",
        ft = "yuck",
        dependencies = { 'gpanders/nvim-parinfer'}
    },

}
