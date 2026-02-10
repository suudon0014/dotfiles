if vim.g.vscode then
    return {}
end

return {
    {
        'saghen/blink.cmp',
        event = { 'VeryLazy' },
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'saghen/blink.compat',
                version = '*',
                opts = { impersonate_nvim_cmp = true },
            },
            'vim-skk/skkeleton',
            'uga-rosa/cmp-skkeleton',
            'Xantibody/blink-cmp-skkeleton',
        },
        version = '1.*',

        opts = {
            keymap = { preset = 'super-tab' },
            appearance = { nerd_font_variant = 'mono', },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 100 },
                trigger = {
                    show_on_backspace = true,
                    show_on_backspace_in_keyword = true,
                    show_on_insert = true,
                },
            },
            cmdline = {
                completion = { menu = { auto_show = true } },
                keymap = {
                    preset = 'cmdline',
                    ['<Tab>'] = { 'select_and_accept', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' }
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
            sources = {
                default = { 'skkeleton', 'lsp', 'lazydev', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    markdown = { 'obsidian', 'obsidian_new', 'obsidian_tags', 'skkeleton', 'lsp', 'path', 'snippets', 'buffer' },
                },
                providers = {
                    skkeleton = {
                        name = 'skkeleton',
                        module = 'blink-cmp-skkeleton',
                        score_offset = 100,
                    },
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    }
}
