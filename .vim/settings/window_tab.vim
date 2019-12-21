"window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap sR <C-w>R
nnoremap s= <C-w>=
nnoremap sO <C-w>=
nnoremap sw <C-w>w
nnoremap so :<C-u>vertical res<CR><C-w>_
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sc :<C-u>only<CR>
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

" submode
let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 2000

" submode : window_mode
call submode#enter_with('window_mode', 'n', '', 's>', '<C-w>>')
call submode#enter_with('window_mode', 'n', '', 's.', '<C-w>>')
call submode#enter_with('window_mode', 'n', '', 's<', '<C-w><')
call submode#enter_with('window_mode', 'n', '', 's,', '<C-w><')
call submode#enter_with('window_mode', 'n', '', 's+', '<C-w>+')
call submode#enter_with('window_mode', 'n', '', 's;', '<C-w>+')
call submode#enter_with('window_mode', 'n', '', 's-', '<C-w>-')
call submode#enter_with('window_mode', 'n', '', 's=', '<C-w>-')
call submode#enter_with('window_mode', 'n', '', 'sn', 'gt')
call submode#enter_with('window_mode', 'n', '', 'sp', 'gT')
call submode#enter_with('window_mode', 'n', '', 'sl', '<C-w>l')
call submode#enter_with('window_mode', 'n', '', 'sh', '<C-w>h')
call submode#enter_with('window_mode', 'n', '', 'sj', '<C-w>j')
call submode#enter_with('window_mode', 'n', '', 'sk', '<C-w>k')
call submode#enter_with('window_mode', 'n', '', 'sL', '<C-w>L')
call submode#enter_with('window_mode', 'n', '', 'sH', '<C-w>H')
call submode#enter_with('window_mode', 'n', '', 'sJ', '<C-w>J')
call submode#enter_with('window_mode', 'n', '', 'sK', '<C-w>K')
call submode#enter_with('window_mode', 'n', '', 'sr', '<C-w>r')
call submode#enter_with('window_mode', 'n', '', 'sR', '<C-w>R')
call submode#enter_with('window_mode', 'n', '', 'sO', '<C-w>=')
call submode#enter_with('window_mode', 'n', '', 'so', ':<C-u>vertical res<CR><C-w>_')
call submode#enter_with('window_mode', 'n', '', 'sw', '<C-w>w')
call submode#enter_with('window_mode', 'n', '', 'ss', ':<C-u>sp<CR>')
call submode#enter_with('window_mode', 'n', '', 'sv', ':<C-u>vs<CR>')
call submode#enter_with('window_mode', 'n', '', 'sc', ':<C-u>only<CR>')
call submode#enter_with('window_mode', 'n', '', 'sq', ':<C-u>q<CR>')
call submode#enter_with('window_mode', 'n', '', 'sQ', ':<C-u>bd<CR>')
call submode#enter_with('window_mode', 'n', '', 'st', ':<C-u>tabnew<CR>')

call submode#map('window_mode', 'n', '', '>', '<C-w>>')
call submode#map('window_mode', 'n', '', '.', '<C-w>>')
call submode#map('window_mode', 'n', '', '<', '<C-w><')
call submode#map('window_mode', 'n', '', ',', '<C-w><')
call submode#map('window_mode', 'n', '', '+', '<C-w>+')
call submode#map('window_mode', 'n', '', ';', '<C-w>+')
call submode#map('window_mode', 'n', '', '-', '<C-w>-')
call submode#map('window_mode', 'n', '', '=', '<C-w>-')
call submode#map('window_mode', 'n', '', 'n', 'gt')
call submode#map('window_mode', 'n', '', 'p', 'gT')
call submode#map('window_mode', 'n', '', 'l', '<C-w>l')
call submode#map('window_mode', 'n', '', 'h', '<C-w>h')
call submode#map('window_mode', 'n', '', 'j', '<C-w>j')
call submode#map('window_mode', 'n', '', 'k', '<C-w>k')
call submode#map('window_mode', 'n', '', 'L', '<C-w>L')
call submode#map('window_mode', 'n', '', 'H', '<C-w>H')
call submode#map('window_mode', 'n', '', 'J', '<C-w>J')
call submode#map('window_mode', 'n', '', 'K', '<C-w>K')
call submode#map('window_mode', 'n', '', 'r', '<C-w>r')
call submode#map('window_mode', 'n', '', 'R', '<C-w>R')
call submode#map('window_mode', 'n', '', 'O', '<C-w>=')
call submode#map('window_mode', 'n', '', 'o', ':<C-u>vertical res<CR><C-w>_')
call submode#map('window_mode', 'n', '', 'w', '<C-w>w')
call submode#map('window_mode', 'n', '', 's', ':<C-u>sp<CR>')
call submode#map('window_mode', 'n', '', 'v', ':<C-u>vs<CR>')
call submode#map('window_mode', 'n', '', 'c', ':<C-u>only<CR>')
call submode#map('window_mode', 'n', '', 'q', ':<C-u>q<CR>')
call submode#map('window_mode', 'n', '', 'Q', ':<C-u>bd<CR>')
call submode#map('window_mode', 'n', '', 't', ':<C-u>tabnew<CR>')

call submode#leave_with('window_mode', 'n', '', 'e')

" submode : undo/redo_mode
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
call submode#leave_with('undo/redo', 'n', '', 'e')

"tab
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
