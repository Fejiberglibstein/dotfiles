return {
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.cmd[[
                xmap <leader>a <Plug>(EasyAlign)
                nmap <leader>a <Plug>(EasyAlign)
            ]]
        end
    }
}
