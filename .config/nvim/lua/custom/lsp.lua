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
        vim.keymap.set('i', '<c-y>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: signature help' })

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
vim.lsp.config["lua_ls"] = {
    Lua = {
        workspace = {
            userThirdParty = {os.getenv("HOME") .. ".local/share/LuaAddons"},
            checkThirdParty = "Apply",
            telemetry = { enable = false },
            library = {
                [vim.fn.expand "${3rd}/love2d/library"] = true,
            }
        },
        diagnostics = { global = { 'love' } }
    }
}
vim.lsp.config["clangd"] = {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--clang-tidy-checks=*",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
    },
    init_options = {
        clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    },
}

require('lspconfig')["tinymist"].setup { "/home/" }
vim.lsp.config["tinymist"] = {
    settings = {
        formatterMode = "typstyle",
        formatterPrintWidth = 80,
        rootPath = "/home/"
    },
}

-- require('mason-lspconfig').setup_handlers({
--     -- :h mason-lspconfig-automatic-server-setup
--     function(server_name)
--         require('lspconfig')[server_name].setup {}
--     end,
--     ["rust_analyzer"] = function()
--         require('lspconfig')['rust_analyzer'].setup {
--             settings = {
--                 ["rust-analyzer"] = {
--                     -- check = { command = "clippy" }
--
--                 }
--             }
--
--         }
--     end,
--     -- Commented out because it makes neovim take 20 seconds to start. I think I
--     -- need to provide a .venv file somewhere, since it is currently searching
--     -- my entire computer for it lol
--     -- ['pylsp'] = function()
--     --     -- print(vim.fn.finddir(".venv", '**;'))
--     --     require('lspconfig')['pylsp'].setup {
--     --         cmd_env = { VIRTUAL_ENV = vim.fn.finddir(".venv", '**;') },
--     --     }
--     -- end,
--     ["lua_ls"] = function()
--         require('lspconfig')["lua_ls"].setup {
--             settings = {
--                 Lua = {
--                     workspace = {
--                         checkThirdParty = false,
--                         telemetry = { enable = false },
--                         library = {
--                             "${3rd}/love2d/library"
--                         }
--                     }
--                 }
--             }
--         }
--     end,
--     ["clangd"] = function()
--         require('lspconfig')["clangd"].setup {
--             cmd = {
--                 "clangd",
--                 "--background-index",
--                 "--clang-tidy",
--                 "--clang-tidy-checks=*",
--                 "--completion-style=bundled",
--                 "--cross-file-rename",
--                 "--header-insertion=iwyu",
--             },
--             init_options = {
--                 clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
--                 usePlaceholders = true,
--                 completeUnimported = true,
--                 semanticHighlighting = true,
--             },
--         }
--     end,
--     ["tinymist"] = function()
--         require('lspconfig')["tinymist"].setup {
--             settings = {
--                 formatterMode = "typstyle",
--                 formatterPrintWidth = 80,
--             },
--         }
--     end
-- })
