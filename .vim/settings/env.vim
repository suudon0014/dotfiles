" configs for specific environment
if has('kaoriya')
    let g:no_vimrc_example=0
    let g:vimrc_local_finish=1
    let g:gvimrc_local_finish=1

	"$VIM/plugins/kaoriya/autodate.vim
	let plugin_autodate_disable  = 1
	"$VIM/plugins/kaoriya/cmdex.vim
	let plugin_cmdex_disable     = 1
	"$VIM/plugins/kaoriya/dicwin.vim
	let plugin_dicwin_disable    = 1
	"$VIMRUNTIME/plugin/format.vim
	let plugin_format_disable    = 1
	"$VIM/plugins/kaoriya/hz_ja.vim
	let plugin_hz_ja_disable     = 1
	"$VIM/plugins/kaoriya/scrnmode.vim
	let plugin_scrnmode_disable  = 1
	"$VIM/plugins/kaoriya/verifyenc.vim
	let plugin_verifyenc_disable = 1
endif

if has('win64')
    let s:python_path = fnamemodify('~/.venv/neovim2/Scripts/python.exe', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/Scripts/python.exe', ':p')
elseif has('unix')
    let s:python_path = fnamemodify('~/.venv/neovim2/bin/python', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/bin/python', ':p')
endif

if executable(s:python_path)
  let g:python_host_prog = s:python_path
endif
if executable(s:python3_path)
  let g:python3_host_prog = s:python3_path
endif
