# Dotfiles Configuration

This repository contains the user's personal configuration files (dotfiles) for various development tools and environments. It is designed to work primarily on Windows (via MSYS2/Git Bash and Scoop) and Linux.

## Project Overview

*   **Primary OS:** Windows (with MSYS2/MinGW), Linux.
*   **Shells:** Zsh (primary), Fish (configurations available).
*   **Editor:** Neovim (primary) and Vim. The configuration relies heavily on Lua and external plugin managers.
*   **Terminal:** WezTerm, Windows Terminal.
*   **Package Manager:** Scoop (Windows).
*   **AI CLI:** Gemini CLI.

## Directory Structure

*   **`.vim/`**: The core configuration for Vim and Neovim.
    *   `init.lua`: Entry point for Neovim.
    *   `lua/`: Lua modules for Neovim (mappings, settings, LSP, etc.).
    *   `toml/`: TOML files defining plugins and their configurations (used by `dein.vim` / `dpp.vim`).
    *   `settings/`: TypeScript and Vimscript configurations for the `dpp.vim` plugin manager.
*   **`.fish/`**: Configuration for the Fish shell.
*   **`.zsh/`**: Configuration for the Zsh shell (`.zshrc`).
*   **`gemini-cli/`**: Configuration and custom commands for the Gemini CLI.
*   **`lazygit/`**: Configuration for `lazygit`.
*   **`scoop/`**: Windows package management configuration.
    *   `scoopfile.json`: Exported list of installed Scoop apps.
    *   `windows_terminal_settings.json`: Settings for Windows Terminal.
*   **`install.sh`**: The main setup script to symlink dotfiles to their appropriate locations.
*   **`.wezterm.lua`**: Configuration for the WezTerm terminal emulator.
*   **`.tmux.conf`**: Configuration for Tmux.
*   **`.latexmkrc`**: Configuration for LaTeX compilation (latexmk).
*   **`config.ctags`**: Configuration for Ctags.

## Installation & Usage

### 1. Setup

The `install.sh` script handles the symlinking of configuration files to the user's home directory or `XDG_CONFIG_HOME`.

```bash
./install.sh
```

**What the script does:**
*   Sets up `XDG_CONFIG_HOME`.
*   Detects OS (MSYS/MINGW for Windows, Linux).
*   Symlinks:
    *   Neovim: `init.lua` -> `init.vim` (compatibility), `ginit.vim`.
    *   Vim: `.vimrc`, `.gvimrc`.
    *   Git: `.gitconfig`, `.git_commit_template`.
    *   Shell: `.zshrc` (Fish config linking is currently commented out).
    *   Lazygit: `config.yml`.
    *   Tmux: `.tmux.conf`.
    *   LaTeX: `.latexmkrc`.
    *   Gemini CLI: `GEMINI.md`, `settings.json`, `commands/` -> `~/.gemini/`.

### 2. Windows Environment (Scoop)

On Windows, the environment is heavily managed by [Scoop](https://scoop.sh/).

*   **Restore Packages:** Use the `scoop/scoopfile.json` to install all tracked applications.
    ```powershell
    scoop import scoop/scoopfile.json
    ```
*   **Key Installed Tools:** `neovim`, `git`, `lazygit`, `ripgrep` (`rg`), `fd`, `bat`, `fzf`, `nodejs`, `python`, `wezterm`.

## Development Conventions

### Git Conventions
*   **Commit Message Title:** Always set the commit title according to the content of `.git_commit_template`.

### Vim/Neovim Configuration
*   **Hybrid Approach:** The config supports both Vim and Neovim, but focuses on Lua for Neovim (`init.lua`).
*   **Plugin Management:**
    *   Uses **dein.vim** and is transitioning to/using **dpp.vim**.
    *   **TOML-based Config:** Plugins are defined in `toml/*.toml` files, separating "lazy" loaded plugins (`*_lazy.toml`) from startup plugins.
    *   **Lua Modules:** Logic is split into modular files in `.vim/lua/` (e.g., `mappings.lua`, `nvim-lsp.lua`).
*   **Environment:** The setup assumes the presence of tools like `ripgrep` and `fd` for searching and file finding (configured in `ddu_rc.lua` and `ddu_lazy.toml`).

### Shell & Terminal
*   **Cross-Platform:** Scripts and configs try to account for both Windows and Linux paths/behaviors.
*   **Terminals:** WezTerm is configured via Lua (`.wezterm.lua`), and Windows Terminal settings are backed up in `scoop/`.

### Gemini CLI
*   **Configuration:** The settings and custom commands for the Gemini CLI are managed in `gemini-cli/` and symlinked to `~/.gemini/` by `install.sh`.
