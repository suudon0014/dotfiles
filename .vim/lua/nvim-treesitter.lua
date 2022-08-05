require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
        disable = {"markdown",},
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
}
