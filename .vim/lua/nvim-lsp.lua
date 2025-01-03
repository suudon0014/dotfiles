require('vim.lsp.log').set_level('OFF')

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
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = {noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', '<C-l>a', '<Cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('v', '<C-l>a', '<Cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('n', '<C-l>h', '<Cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', '<C-l>o', '<Cmd>Lspsaga outline<CR>', opts)
    vim.keymap.set('n', '<C-l>s', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<C-l>ci', '<Cmd>Lspsaga incoming_calls<CR>', opts)
    vim.keymap.set('n', '<C-l>co', '<Cmd>Lspsaga outgoing_calls<CR>', opts)
    vim.keymap.set('n', '<C-l>rn', '<Cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set('n', '<C-l>fi', '<Cmd>Lspsaga finder<CR>', opts)
    vim.keymap.set('n', '<C-l>ec', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>el', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>eb', '<Cmd>Lspsaga show_buf_diagnostics<CR>', opts)
    vim.keymap.set('n', '<C-l>ep', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', '<C-l>en', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
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
    vim.keymap.set('n', '<C-l>dg', '<Cmd>Lspsaga goto_definition<CR>', opts)
    vim.keymap.set('n', '<C-l>dp', '<Cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', '<C-l>dtg', '<Cmd>Lspsaga goto_type_definition<CR>', opts)
    vim.keymap.set('n', '<C-l>dtp', '<Cmd>Lspsaga peek_type_definition<CR>', opts)
    opts['desc'] = 'vim.lsp.buf.references()'
    vim.keymap.set('n', '<C-l>rf', function() vim.lsp.buf.references() end, opts)
    opts['desc'] = 'vim.lsp.buf.format()'
    vim.keymap.set('n', '<C-l>fo', function() vim.lsp.buf.format {async=true} end, opts)
    vim.keymap.set('v', '<C-l>fo', function() vim.lsp.buf.format {async=true} end, opts)
    opts['desc'] = 'vim.lsp.buf.declaration()'
    vim.keymap.set('n', '<C-l>gc', function() vim.lsp.buf.declaration() end, opts)
    opts['desc'] = 'vim.lsp.buf.implementation()'
    vim.keymap.set('n', '<C-l>gi', function() vim.lsp.buf.implementation() end, opts)

    if client.server_capabilities.documentHighlightProvider then
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
mason_lspconfig.setup_handlers({ function(server_name)
    local opts = {}
    opts.on_attach = on_attach
    opts.detached = false
    opts.capabilities = capabilities
    opts.single_file_support = true

    if server_name == 'clangd' then
        opts.cmd = {
            "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
            "--limit-results=0",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        }
        opts.init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        }
        opts.capabilities.offsetEncoding = {"utf-16"}
    elseif server_name == 'lua_ls' then
        opts.settings = {
            Lua = {
              runtime = {version = 'LuaJIT'},
              diagnostics = {globals = {'vim'}},
              workspace = {library = vim.api.nvim_get_runtime_file("", true)},
              telemetry = {enable = false},
            },
        }
    elseif server_name == 'marksman' then
        opts.cmd = {'marksman.cmd'}
    elseif server_name == 'bashls' then
        opts.filetypes = {'sh', 'zsh'}
    elseif server_name == 'rust_analyzer' then
        require('rust-tools').setup({
            server = {
                on_attach = on_attach,
            }
        })
    elseif server_name == 'denols' then
        opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
        opts.init_options = {
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
        }
    elseif server_name == 'tsserver' then
        opts.root_dir = lspconfig.util.root_pattern("package.json")
        opts.single_file_support = false
    end

    lspconfig[server_name].setup(opts)
end })

require("fidget").setup{
    progress = {
        display = {
            progress_icon = {
                pattern = 'moon',
            },
        },
    },
}
