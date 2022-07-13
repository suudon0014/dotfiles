local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = {noremap=true, silent=true}
        buf_set_keymap('n', '<C-l>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<C-l>c', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', '<C-l>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', '<C-l>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<C-l>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-l>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<C-l>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<C-l>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<C-l>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        buf_set_keymap('n', '<C-l>l', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<C-l>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', '<C-l>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- Set up of LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == 'clangd' then
        local cmd = {
            "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never"
        }
        opts.cmd = cmd
    end

    opts.on_attach = on_attach
    opts.capabilities = capabilities

    server:setup(opts)
end)
