# Vim/Neovim Configurations

Configuration files for Vim and Neovim, located within the `.vim` directory.

## Directory Structure & Files

- **.vim/**
    - **init.lua** : Entry point for Neovim configuration.
    - **.vimrc** : Configuration for standard Vim.
    - **.gvimrc** : Configuration for GUI Vim.
    - **.ideavimrc** : Configuration for IdeaVim.
    - **.vsvimrc** : Configuration for VsVim.

    - **lua/** : Lua modules for Neovim configuration.
        - **ddc_rc.lua** : Configurations for ddc.vim (completion framework).
        - **ddu_rc.lua** : Configurations for ddu.vim (dark denim union - fuzzy finder).
        - **dein_rc.lua** : Configurations for dein.vim plugin manager.
        - **extui.lua** : Configurations for external UI integrations.
        - **gitsigns.lua** : Setup for gitsigns.nvim.
        - **mappings.lua** : Global key mappings.
        - **nvim-lsp.lua** : LSP (Language Server Protocol) configurations.
        - **nvim-treesitter.lua** : Tree-sitter configurations for syntax highlighting and more.
        - **sets.lua** : General editor options (set commands).
        - **submode.lua** : Window and tab manipulation mappings (simulating submode).

    - **settings/** : Configuration files for plugin managers.
        - **dpp_config.ts** : Main configuration file for dpp.vim (TypeScript).
        - **dpp_install.vim** : Installation script for dpp.vim.

    - **toml/** : TOML files defining plugins and their configurations (used by dein.vim and dpp.vim).
        - **dein.toml** : Plugins loaded on startup.
        - **dein_lazy.toml** : Lazily loaded plugins.
        - **ddc_lazy.toml** : Plugins related to ddc.vim.
        - **ddu_lazy.toml** : Plugins related to ddu.vim.
        - **treesitter_lazy.toml** : Plugins related to Tree-sitter.
        - *(and other lazy loading configuration files)*
