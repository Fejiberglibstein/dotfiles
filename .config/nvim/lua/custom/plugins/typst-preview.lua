return {
    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',

        opts = {
            debug = true,
            get_root = function(path)
                if (string.find(path, "vault")) then
                    return "/home/austint"
                end
                return "/home/austint"
                -- return path
            end,
            open_cmd = 'firefox --new-window %s',
            dependencies_bin = {
                ['tinymist'] = vim.fn.stdpath('data') .. '/mason/bin/tinymist'
            },
            -- invert_colors = 'always',
        }, -- lazy.nvim will implicitly calls `setup {}`
    },
}
