local M = {}

function M.setup()
    require('vim.lsp.log').set_level('OFF')

    vim.diagnostic.config({
        float = {
            border = 'rounded',
        }
    })

    local on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_set_option_value(...) end
        local opts = {noremap=true, silent=true, buffer=bufnr}
        vim.keymap.set('n', '<C-l>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('v', '<C-l>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<C-l>ci', vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set('n', '<C-l>co', vim.lsp.buf.outgoing_calls, opts)
        vim.keymap.set('n', '<C-l>ec', function() vim.diagnostic.open_float({scope = 'cursor'}) end, opts)
        vim.keymap.set('n', '<C-l>el', function() vim.diagnostic.open_float({scope = 'line'}) end, opts)
        vim.keymap.set('n', '<C-l>eb', function() vim.diagnostic.open_float({scope = 'buffer'}) end, opts)
        vim.keymap.set('n', '<C-l>ep', function() vim.diagnostic.jump({count = 1, float = true}) end, opts)
        vim.keymap.set('n', '<C-l>en', function() vim.diagnostic.jump({count = -1, float = true}) end, opts)
        vim.keymap.set('n', '<C-l>dp', '<Cmd>Lspsaga peek_definition<CR>', opts)
        vim.keymap.set('n', '<C-l>dtp', '<Cmd>Lspsaga peek_type_definition<CR>', opts)

        vim.keymap.set('n', '<C-l>h', function() vim.lsp.buf.hover({border = 'rounded'}) end, opts)
        vim.keymap.set('n', '<C-l>s', function() vim.lsp.buf.signature_help({border = 'rounded'}) end, opts)
        vim.keymap.set('n', '<C-l>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<C-l>et', function()
            local config = vim.diagnostic.config()
            local toggled_underline = not config.underline
            local toggled_virtual_text = not config.virtual_text
            local toggled_signs = not config.signs
            vim.diagnostic.config({
                underline = toggled_underline,
                virtual_text = toggled_virtual_text,
                signs = toggled_signs,
            })
        end, opts)
        vim.keymap.set('n', '<C-l>dg', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<C-l>dtg', vim.lsp.buf.type_definition, opts)
        opts['desc'] = 'vim.lsp.buf.references()'
        vim.keymap.set('n', '<C-l>rf', vim.lsp.buf.references, opts)
        opts['desc'] = 'vim.lsp.buf.format()'
        vim.keymap.set('n', '<C-l>fo', function() vim.lsp.buf.format {async=true} end, opts)
        vim.keymap.set('v', '<C-l>fo', function() vim.lsp.buf.format {async=true} end, opts)
        opts['desc'] = 'vim.lsp.buf.declaration()'
        vim.keymap.set('n', '<C-l>gc', vim.lsp.buf.declaration, opts)
        opts['desc'] = 'vim.lsp.buf.implementation()'
        vim.keymap.set('n', '<C-l>gi', vim.lsp.buf.implementation, opts)

        if client.server_capabilities.documentHighlightProvider then
            local hl_opts = { underline = true, bg = '#104040' }
            vim.api.nvim_set_hl(0, 'LspReferenceText', hl_opts)
            vim.api.nvim_set_hl(0, 'LspReferenceRead', hl_opts)
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', hl_opts)

            local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end

    -- Set up of LSP servers
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    }

    vim.lsp.config('*', {
        on_attach = on_attach,
        detached = false,
        capabilities = capabilities,
        single_file_support = true,
    })

    vim.lsp.config('clangd', {
        cmd = {
            "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--completion-style=bundled",
            "--header-insertion=never",
            "--limit-results=200",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        capabilities = {
            offsetEncoding = {"utf-16"},
        },
    })

    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
              runtime = {version = 'LuaJIT'},
              diagnostics = {globals = {'vim', 'require'}},
              workspace = {checkThirdParty = false},
              telemetry = {enable = false},
            },
        }
    })

    vim.lsp.config('denols', {
        single_file_support = false,
        root_markers = {"deno.json", "deno.jsonc", "deno.lock"},
        init_options = {
            lint = true,
            unstable = true,
            suggest = {
                imports = {
                    hosts = {
                        ["https://deno.land"] = true,
                        ["https://cdn.nest.land"] = true,
                        ["https://crux.land"] = true,
                    },
                },
            },
        },
    })

    -- local lspconfig = require("lspconfig")
    -- vim.lsp.config('ts_ls', {
    --     root_dir = lspconfig.util.root_pattern("package.json"),
    --     single_file_support = false
    -- })
end

return M
