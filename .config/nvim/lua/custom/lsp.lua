vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Go to the definition of symbol under cursor
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
        -- Find all references for symbol under cursor
        map('gr', require('telescope.builtin').lsp_references, 'Go to references')

        -- Go to type definition of word under cursor
        map('gD', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')

        -- LOOK INTO:
        --
        -- require('telescope.builtin').lsp_document_symbols
        -- require('telescope.builtin').lsp_dynamic_workspace_symbols

        -- Rename symbol under cursor
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>rr', vim.lsp.buf.references, 'References')

        -- Execute code action under cursor
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Diagnostic Keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

        -- Toggle inlay hints if it's supported
        --
        -- Not on by default because idk if it's nice or not
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities and vim.lsp.inlay_hint then
            vim.api.nvim_buf_create_user_command(event.buf, 'ToggleInlayHints', function()
                ---@diagnostic disable-next-line: missing-parameter
                print("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled() and 'off' or 'on'))
                ---@diagnostic disable-next-line: missing-parameter
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, {})
        end
    end
})

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L551-L554
-- info
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers({
    -- :h mason-lspconfig-automatic-server-setup
    function(server_name)
        require('lspconfig')[server_name].setup {}
    end,
    ["rust_analyzer"] = function()
        require('lspconfig')['rust_analyzer'].setup {
            settings = {
                ["rust-analyzer"] = {
                    -- check = { command = "clippy" }

                }
            }

        }
    end,
    ["lua_ls"] = function()
        require('lspconfig')["lua_ls"].setup {
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                        telemetry = { enable = false },
                        library = {
                            "${3rd}/love2d/library"
                        }
                    }
                }
            }
        }
    end
})
