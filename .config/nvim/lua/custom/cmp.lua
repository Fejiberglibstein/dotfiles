local cmp = require('cmp');
local luasnip = require('luasnip');
luasnip.config.setup({
    enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/luasnip/" } })

local function cmp_picker(opts)
    opts = opts or {};

    local picker = require('telescope.pickers');
    local finder = require('telescope.finders');
    local conf = require('telescope.config').values;
    local previewer = require('telescope.previewers');
    local actions = require('telescope.actions');
    local actions_state = require('telescope.actions.state');

    local results = cmp.get_entries()

    picker.new(opts, {
        prompt_title = 'Cmp options',
        finder = finder.new_table({
            results = results,
            entry_maker = function(entry)
                --- @cast entry cmp.Entry
                return {
                    value = entry,
                    display = entry.completion_item.label,
                    ordinal = entry.completion_item.label
                };
            end
        }),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr);

                local option = {}
                option.select = option.select or false
                option.behavior = option.behavior or cmp.get_config().confirmation.default_behavior or
                    cmp.ConfirmBehavior.Insert

                local selection = actions_state.get_selected_entry().value;

                cmp.core:confirm(selection, {
                    behavior = option.behavior
                }, function()
                    cmp.core:complete(cmp.core:get_context({ reason = cmp.ContextReason.TriggerOnly }))
                end)
            end)

            return true
        end,

        sorter = conf.generic_sorter(opts),
        previewer = previewer.new_buffer_previewer({
            title = 'LSP description',
            define_preview = function(self, entry, _)
                local value = entry.value
                ---@cast value cmp.Entry
                value:resolve(function()
                    if not (value.resolved_completion_item and value.resolved_completion_item.documentation) then
                        return
                    end

                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, value:get_documentation())
                    vim.bo[self.state.bufnr].filetype = 'markdown'

                    vim.wo[self.state.winid].conceallevel = 3
                    vim.wo[self.state.winid].wrap = true
                end)
            end



        })
    }):find()
end

cmp.setup({
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -1,
            side_padding = 0,
        },
    },
    formatting = {
        expandable_indicator = true,
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            --- @type vim.CompletedItem
            local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)

            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    completion = { autocomplete = { 'InsertEnter', 'TextChanged' }, completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
        -- Select the next item
        -- If the completion menu isn't already open, open it.
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),
        -- Select the prev item
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp_picker({})
            end
        end),

        -- Scroll the documentation window backwards and forwards
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),

        -- Accept the completion
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),

        -- Move forward in the snippet expansion
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),

        -- Move backward in snippet expansion
        ['<C-h>'] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),

        -- Cycle through choice nodes
        ['<C-f>'] = cmp.mapping(function()
            luasnip.select_choice()
        end, { 'i', 's' })

        -- For more luasnip keymaps, look at
        -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    sources = {
        { name = 'nvim_lsp', priority = 1 },
        { name = 'luasnip',  priority = -2 },
        { name = 'path',     priority = -1 },
    }
})
