local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
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

        -- パフォーマンス改善: 大きなファイルではTreesitterを無効にする
        disable = function(lang, buf)
            local max_filesize = 10 * 1024 * 1024 -- 10 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = {
        enable = true,
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

local hlargs_ok, hlargs = pcall(require, 'hlargs')
if hlargs_ok then
    hlargs.setup({
        excluded_filetypes = {'toml'},
    })
end
