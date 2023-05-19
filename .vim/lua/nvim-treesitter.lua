require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash", "c", "c_sharp", "cmake", "comment", "cpp", "diff", "dockerfile", "git_config", "git_rebase",
        "gitattributes", "gitcommit", "gitignore", "html", "java", "javascript", "jsdoc", "json", "latex", "lua",
        "luadoc", "make", "markdown", "markdown_inline", "matlab", "python", "r", "regex", "rust", "sql",
        "todotxt", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"markdown"},
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
            },
            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'v',
                ['@class.outer'] = '<C-v>',
                ['@loop.outer'] = 'v',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<Leader>n"] = {"@parameter.inner"},
            },
            swap_previous = {
                ["<Leader>p"] = {"@parameter.inner"},
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'single',
            peek_definition_code = {
                ["<C-l>pf"] = "@function.outer",
                ["<C-l>pc"] = "@class.outer",
            },
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        },
    },
}

require('hlargs').setup({
    excluded_filetypes = {'toml'},
})
