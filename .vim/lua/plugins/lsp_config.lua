if vim.g.vscode then
    return {}
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
            'glepnir/lspsaga.nvim',
            'j-hui/fidget.nvim',
        },
        event = {'BufReadPost', 'BufNewFile', 'VeryLazy'},
        config = function()
            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = { 'lspinfo' },
                callback = function()
                    vim.keymap.set('n', 'q', vim.cmd.close, { remap = false, buffer = true, silent = true })
                end,
            })
            require('nvim-lsp').setup()
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        lazy = true,
        opts = {
            outline = {
                auto_preview = false,
                keys = {
                    jump = '<CR>',
                    expand_collapse = 'o',
                },
            },
        },
    },
    {
        'j-hui/fidget.nvim',
        lazy = true,
        opts = {
            progress = { display = { progress_icon = { pattern = 'moon' }}},
        },
    },
    {
        'mason-org/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
        config = function()
            require("mason").setup({
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
            require('lazy').load({ plugins = { 'mason-lspconfig.nvim' }})
        end,
    },
    {
        'mason-org/mason-lspconfig.nvim',
        lazy = true,
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = { path = '${3rd}/luv/library', words = { 'vim%.uv' }},
        },
    }
}
