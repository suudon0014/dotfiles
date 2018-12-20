let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd C:\Users\sudo\dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +164 sweepScript_mine\get_sweep_wave03.m
badd +1 e:\★作業中\プロトタイプ\SINE\main.m
badd +1 e:\★作業中\プロトタイプ\SINE\test_setting.m
badd +92 e:\★作業中\プロトタイプ\SINE\.tags
badd +131 .vimrc
badd +66 e:\★作業中\プロトタイプ\SINE\todo.md
badd +1 sweepScriptMine\bmac_han02.m
badd +1 sweepScriptMine\getSegLevel03.m
badd +1 e:\★作業中\プロトタイプ\SINE\sweepScrpt\test01.m
badd +1 e:\★作業中\プロトタイプ\SINE\getBinnedData.m
badd +1 e:\★作業中\プロトタイプ\SINE\getDrvThetas.m
badd +6 e:\★作業中\プロトタイプ\SINE\getInitialTheta.m
badd +14 e:\★作業中\プロトタイプ\SINE\trackingForEveryHalfWave.m
badd +28 e:\★作業中\プロトタイプ\SINE\createMultiSweepData.m
badd +19 e:\★作業中\プロトタイプ\SINE\createSingleSweepData.m
badd +721 e:\★作業中\プロトタイプ\SINE\AnaResp\AnaResp.cpp
badd +11 e:\★作業中\プロトタイプ\SINE\drawGraph.m
badd +4 e:\★作業中\プロトタイプ\SINE\getPhaseShiftedSine.m
badd +1 C:\Users\sudo\Documents\.vsconfig
badd +865 e:\matlab_script\rainflowfunc\index.html
badd +21 e:\matlab_script\rainflowfunc\license.txt
badd +1 e:\matlab_script\draw_rainflow_graph.m
badd +1 e:\matlab_script\strain_gauge_data.m
badd +1 e:\matlab_script\strain_data_analysis.m
badd +276 e:\matlab_script\6dof\6dofGraph.m
badd +0 e:\★作業中\プロトタイプ\SINE\NERD_tree_3
badd +1 dein.toml
badd +64 dein_lazy.toml
argglobal
silent! argdel *
edit e:\★作業中\プロトタイプ\SINE\main.m
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 66 + 69) / 139)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 72 + 69) / 139)
exe '3resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 72 + 69) / 139)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 92 - ((14 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
92
normal! 012|
wincmd w
argglobal
if bufexists('e:\★作業中\プロトタイプ\SINE\drawGraph.m') | buffer e:\★作業中\プロトタイプ\SINE\drawGraph.m | else | edit e:\★作業中\プロトタイプ\SINE\drawGraph.m | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 11 - ((6 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
let s:c = 8 - ((2 * winwidth(0) + 36) / 72)
if s:c > 0
  exe 'normal! ' . s:c . '|zs' . 8 . '|'
else
  normal! 08|
endif
wincmd w
argglobal
if bufexists('e:\★作業中\プロトタイプ\SINE\createMultiSweepData.m') | buffer e:\★作業中\プロトタイプ\SINE\createMultiSweepData.m | else | edit e:\★作業中\プロトタイプ\SINE\createMultiSweepData.m | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 66 + 69) / 139)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 72 + 69) / 139)
exe '3resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 72 + 69) / 139)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
