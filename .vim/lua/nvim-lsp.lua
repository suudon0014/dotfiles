require('vim.lsp.log').set_level('OFF')

local saga = require('lspsaga')
saga.setup({
    outline = {
        auto_preview = false,
        keys = {
            jump = '<CR>',
            expand_collapse = 'o',
        },
    },
})

local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_set_option_value(...) end
    local opts = {noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', '<C-l>a', '<Cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('v', '<C-l>a', '<Cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('n', '<C-l>o', '<Cmd>Lspsaga outline<CR>', opts)
    vim.keymap.set('n', '<C-l>ci', '<Cmd>Lspsaga incoming_calls<CR>', opts)
    vim.keymap.set('n', '<C-l>co', '<Cmd>Lspsaga outgoing_calls<CR>', opts)
    vim.keymap.set('n', '<C-l>fi', '<Cmd>Lspsaga finder<CR>', opts)
    vim.keymap.set('n', '<C-l>ec', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>el', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>eb', '<Cmd>Lspsaga show_buf_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>ep', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', '<C-l>en', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
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
        vim.api.nvim_exec2([[
            highlight LspReferenceText  cterm=underline ctermbg=8 gui=underline guibg=#104040
            highlight LspReferenceRead  cterm=underline ctermbg=8 gui=underline guibg=#104040
            highlight LspReferenceWrite cterm=underline ctermbg=8 gui=underline guibg=#104040
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], {})

    end
end

-- Set up of LSP servers
local capabilities = require('ddc_source_lsp').make_client_capabilities()
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

local mason = require("mason")
mason.setup({
    ui = {
        check_outdated_packages_on_open = false,
        border = "single",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("ddc_source_lsp_setup").setup()
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

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
          workspace = {library = vim.api.nvim_get_runtime_file("", true)},
          telemetry = {enable = false},
        },
    }
})

vim.lsp.config('denols', {
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deno.lock"),
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

-- vim.lsp.config('ts_ls', {
--     root_dir = lspconfig.util.root_pattern("package.json"),
--     single_file_support = false
-- })

require("fidget").setup{
    progress = {
        display = {
            progress_icon = {
                pattern = 'moon',
            },
        },
    },
}
