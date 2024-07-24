return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
        'nvim-treesitter/playground',
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("custom.treesitter")
    end
    ,
}
