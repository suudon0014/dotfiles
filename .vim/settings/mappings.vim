let mapleader = "\<Space>"

"map jj to Esc
inoremap <silent> jj <Esc>
cnoremap <silent> jj <Esc>
inoremap <silent> ｊｊ <Esc>
cnoremap <silent> ｊｊ <Esc>
tnoremap <silent> jj <C-\><C-n>

"key bindings of Space + another
noremap <Leader>v g0vg$h
noremap <Leader>d g0vg$hx
noremap <Leader>y g0vg$hy

noremap <Leader>gv 0v$h
noremap <Leader>gd 0v$hx
noremap <Leader>gy 0v$hy

"space + h/l : move to beginning/end of the line
noremap <Leader>h g^
noremap <Leader>l g$
vnoremap <Leader>l g$h

noremap <Leader>gh ^
noremap <Leader>gl $
vnoremap <Leader>gl $h

"move to the bracket counterpart
noremap <Leader>b %

"command line mode
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-Space>h <Home>
cnoremap <C-Space><C-h> <Home>
cnoremap <C-Space>l <End>
cnoremap <C-Space><C-l> <End>
cnoremap <C-d> <Del>

" quickfix and locationlist
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>

autocmd FileType qf call s:qf_my_settings()
function! s:qf_my_settings() abort
    nnoremap <buffer><silent> q :q<CR>
    nnoremap <buffer><silent> + <C-w>+
    nnoremap <buffer><silent> ; <C-w>+
    nnoremap <buffer><silent> - <C-w>-
    nnoremap <buffer><silent> p <CR><C-w>j
    nnoremap <buffer> j j
    nnoremap <buffer> k k
    nnoremap <buffer> gj gj
    nnoremap <buffer> gk gk
endfunction

"buffer
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

" etc.
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
tnoremap <S-Space> <Space>
nnoremap <S-k> <Nop>
nnoremap / /\v
cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"
