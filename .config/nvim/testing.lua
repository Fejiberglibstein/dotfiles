--- @type CatppuccinOptions
local opts = {
    integrations = {
        cmp = true
    },
    flavour = "macchiato",
    show_end_of_buffer = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15
    },
    custom_highlights = function(colors)
        --- @type { [string]: CtpHighlight }
        local latte = require("catppuccin.palettes").get_palette "latte"
        return {
            Pmenu = { bg = colors.mantle },

            CmpItemAbbrDeprecated = { fg = colors.subtext1, bg = "NONE", strikethrough = true },
            CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE", bold = true },
            CmpItemMenu = { fg = colors.pink, bg = "NONE", italic = true },

            CmpItemKindField = { fg = colors.maroon, bg = latte.maroon },
            CmpItemKindProperty = { fg = colors.red, bg = latte.red },
            CmpItemKindEvent = { fg = colors.red, bg = latte.red },

            CmpItemKindText = { fg = colors.green, bg = latte.green },
            CmpItemKindEnum = { fg = colors.green, bg = latte.green },
            CmpItemKindKeyword = { fg = colors.green, bg = latte.green },

            CmpItemKindConstant = { fg = colors.yellow, bg = latte.yellow },
            CmpItemKindConstructor = { fg = colors.yellow, bg = latte.yellow },
            CmpItemKindReference = { fg = colors.yellow, bg = latte.yellow },

            CmpItemKindFunction = { fg = colors.mauve, bg = latte.mauve },
            CmpItemKindStruct = { fg = colors.mauve, bg = latte.mauve },
            CmpItemKindClass = { fg = colors.mauve, bg = latte.mauve },
            CmpItemKindModule = { fg = colors.mauve, bg = latte.mauve },
            CmpItemKindOperator = { fg = colors.mauve, bg = latte.mauve },

            CmpItemKindVariable = { fg = colors.rosewater, bg = latte.rosewater },
            CmpItemKindFile = { fg = colors.rosewater, bg = latte.rosewater },

            CmpItemKindUnit = { fg = colors.peach, bg = latte.peach },
            CmpItemKindSnippet = { fg = colors.peach, bg = latte.peach },
            CmpItemKindFolder = { fg = colors.peach, bg = latte.peach },

            CmpItemKindMethod = { fg = colors.blue, bg = latte.blue },
            CmpItemKindValue = { fg = colors.blue, bg = latte.blue },
            CmpItemKindEnumMember = { fg = colors.blue, bg = latte.blue },

            CmpItemKindInterface = { fg = colors.teal, bg = latte.teal },
            CmpItemKindColor = { fg = colors.teal, bg = latte.teal },
            CmpItemKindTypeParameter = { fg = colors.teal, bg = latte.teal },
        }
    end,
    config = function()
        vim.cmd.colorscheme "catppuccin"
        vim.cmd 'highlight Normal guibg=Transparent'
    end
}

package.loaded['catpuccin'] = nil
require('catppuccin').setup(opts)
