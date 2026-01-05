require('nightfox').setup {
    options = {
        transparent = true,
    },
    palettes = {
        nordfox = {
            green = "#80ab82",
            -- magenta = "#b18deb",
        }
    },
    groups = {
        nordfox = {
            CursorLine = { bg = "#362d45" },
            ColorColumn = { bg = "#362d45" },
            Visual = { bg = "#49346e", },
            Pmenu = { fg = "#C5CDD9", bg = "#231e2b" },
        }
    }
}
