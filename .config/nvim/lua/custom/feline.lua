local ctp_feline = require('catppuccin.groups.integrations.feline')
ctp_feline.setup({})

-- Used to reload feline
package.loaded['feline'] = nil
require("feline").setup({
    components = ctp_feline.get()
})
