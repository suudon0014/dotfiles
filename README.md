# Dotfiles

Windows (MSYS2/MinGW) および Linux 環境向けの個人の開発環境設定ファイル集（Dotfiles）です。
Neovim を中心に、Zsh、WezTerm、Git などの設定を管理しています。

## 概要

*   **OS:** Windows (MSYS2/MinGW), Linux
*   **Shell:** Zsh (メイン), Fish
*   **Editor:** Neovim (Lua + dpp.vim/dein.vim), Vim
*   **Terminal:** WezTerm, Windows Terminal
*   **Package Manager:** Scoop (Windows)
*   **AI CLI:** Gemini CLI

## ディレクトリ構成

主要なディレクトリとファイルの構成は以下の通りです。

```text
.
├── .vim/                # Vim/Neovim の設定 (Lua, Vimscript)
│   ├── init.lua         # Neovim エントリーポイント
│   ├── lua/             # Lua モジュール (LSP, mappings, plugins settings)
│   ├── toml/            # プラグイン定義 (dpp.vim/dein.vim 用)
│   ├── settings/        # dpp.vim 設定 (TypeScript)
│   ├── .vimrc           # Vim 用設定
│   └── .gvimrc          # GUI Vim 用設定
├── .zsh/                # Zsh 設定 (.zshrc)
├── .wezterm.lua         # WezTerm 設定
├── gemini-cli/          # Gemini CLI の設定とカスタムコマンド
├── lazygit/             # Lazygit 設定 (config.yml)
├── scoop/               # Windows 用 Scoop 設定
│   ├── scoopfile.json   # インストール済みアプリ一覧
│   └── ...
├── install.sh           # セットアップ用スクリプト (シンボリックリンク作成)
├── .gitconfig           # Git 設定
└── .git_commit_template # Git コミットメッセージテンプレート
```

## インストール手順

### 1. リポジトリのクローン

ホームディレクトリなどの適切な場所にリポジトリをクローンします。

```bash
git clone https://github.com/suudon0014/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. セットアップスクリプトの実行

`install.sh` を実行して、各設定ファイルのシンボリックリンクを作成します。
このスクリプトは OS (Windows/Linux) を自動判定し、`XDG_CONFIG_HOME` などを適切に設定します。

```bash
./install.sh
```

**スクリプトが行う主な処理:**
*   `~/.config` (XDG_CONFIG_HOME) の作成
*   Neovim (`init.lua`), Vim (`.vimrc`) のリンク
*   Git (`.gitconfig`), Shell (`.zshrc`), WezTerm, Lazygit 設定のリンク
*   Gemini CLI 設定のリンク

### 3. Windows 環境 (Scoop) のセットアップ

Windows の場合、[Scoop](https://scoop.sh/) を使用して必要なツールを一括インストールできます。

```powershell
scoop import scoop/scoopfile.json
```

**主なインストールツール:**
`neovim`, `git`, `lazygit`, `ripgrep`, `fd`, `bat`, `fzf`, `nodejs`, `python`, `wezterm`

## 主な機能と特徴

### Neovim / Vim
*   **プラグイン管理:** `dpp.vim` (TypeScript設定) および `dein.vim` を使用。
*   **構成:** Lua ベースのモジュラー構成 (`.vim/lua/`) と TOML ファイルによるプラグイン定義。
*   **機能:**
    *   LSP (Language Server Protocol) による補完・診断
    *   Tree-sitter によるシンタックスハイライト
    *   ddu.vim / ddc.vim によるファジーファインドと補完
    *   Lazy loading による起動高速化

### Shell & Terminal
*   **Zsh:** 快適なコマンドライン操作のための設定。
*   **WezTerm:** 高機能でクロスプラットフォームなターミナルエミュレーター設定 (`.wezterm.lua`)。

### Gemini CLI
*   AI アシスタント CLI ツール Gemini CLI の設定 (`~/.gemini`) も管理対象に含め、カスタムコマンドや設定を同期しています。

## Git 運用ルール
*   コミットメッセージは `.git_commit_template` の形式に従って記述します。