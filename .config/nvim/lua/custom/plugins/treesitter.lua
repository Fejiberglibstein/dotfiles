return {
    -- "nvim-treesitter/playground",
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("custom.treesitter")
        end,
    },
}
