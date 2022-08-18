vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "single"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "single"
    }
)

local saga = require('lspsaga')
local action = require('lspsaga.action')
saga.init_lsp_saga()

local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = {noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', '<C-l>a', '<Cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('v', '<C-l>a', '<Cmd><C-u>Lspsaga range_code_action<CR>', opts)
    vim.keymap.set('n', '<C-l>h', '<Cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', '<C-l>s', '<Cmd>Lspsaga signature_help<CR>', opts)
    vim.keymap.set('n', '<C-l>rn', '<Cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set('n', '<C-l>fi', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    vim.keymap.set('n', '<C-l>ld', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>cd', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>pd', '<Cmd>Lspsaga preview_definition<CR>', opts)
    vim.keymap.set('n', '<C-l>gp', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', '<C-l>gn', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    opts['desc'] = 'vim.lsp.buf.references()'
    vim.keymap.set('n', '<C-l>rf', function() vim.lsp.buf.references() end, opts)
    opts['desc'] = 'vim.lsp.buf.formatting()'
    vim.keymap.set('n', '<C-l>fo', function() vim.lsp.buf.formatting() end, opts)
    opts['desc'] = 'vim.diagnostic.open_float()'
    vim.keymap.set('n', '<C-l>e', function() vim.diagnostic.open_float() end, opts)
    opts['desc'] = 'vim.lsp.buf.declaration()'
    vim.keymap.set('n', '<C-l>gc', function() vim.lsp.buf.declaration() end, opts)
    opts['desc'] = 'vim.lsp.buf.definition()'
    vim.keymap.set('n', '<C-l>gd', function() vim.lsp.buf.definition() end, opts)
    opts['desc'] = 'vim.lsp.buf.implementation()'
    vim.keymap.set('n', '<C-l>gi', function() vim.lsp.buf.implementation() end, opts)
    opts['desc'] = 'action.smart_scroll_with_saga(1)'
    vim.keymap.set('n', '<C-f>', function() action.smart_scroll_with_saga(1) end, opts)
    opts['desc'] = 'action.smart_scroll_with_saga(-1)'
    vim.keymap.set('n', '<C-b>', function() action.smart_scroll_with_saga(-1) end, opts)

    if client.resolved_capabilities.document_range_formatting then
        opts['desc'] = nil
        vim.keymap.set('v', '<C-l>fo', '<Cmd>lua vim.lsp.buf.range_formatting()<CR><Esc>', opts)
    end
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            highlight LspReferenceText  cterm=underline ctermbg=8 gui=underline guibg=#104040
            highlight LspReferenceRead  cterm=underline ctermbg=8 gui=underline guibg=#104040
            highlight LspReferenceWrite cterm=underline ctermbg=8 gui=underline guibg=#104040
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)

    end
end

-- Set up of LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
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

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({ function(server_name)
    local opts = {}

    if server_name == 'clangd' then
        opts.cmd = {
            "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
            "--limit-results=0",
        }
    end

    if server_name == 'sumneko_lua' then
        opts.settings = {
            Lua = {
              runtime = {version = 'LuaJIT'},
              diagnostics = {globals = {'vim'}},
              workspace = {library = vim.api.nvim_get_runtime_file("", true)},
              telemetry = {enable = false},
            },
        }
    end

    if server_name == 'marksman' then
        opts.cmd = {'marksman.cmd'}
    end

    opts.on_attach = on_attach
    opts.capabilities = capabilities

    lspconfig[server_name].setup(opts)
end })
