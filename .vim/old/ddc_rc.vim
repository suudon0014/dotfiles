" configs about ddc.vim and pum.vim

" mappings
nnoremap : <Cmd>call CommandlinePre()<CR>:

" functions
function! CommandlinePre() abort
    cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y> <Cmd>call pum#map#confirm()<CR>
    cnoremap <C-e> <Cmd>call pum#map#cancel()<CR>
    cnoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR><CR>' : '<Plug>(kensaku-search-replace)<CR>'

    if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
    endif
    call ddc#custom#patch_buffer('cmdlineSources', {
        \ ':': ['cmdline', 'cmdline_history', 'around', 'file', 'path'],
        \ '@': ['input', 'cmdline_history', 'around', 'file', 'path'],
        \ '>': ['input', 'cmdline_history', 'around', 'file', 'path'],
        \ '/': ['around', 'line'],
        \ '?': ['around', 'line'],
        \ '-': ['around', 'line'],
        \ '=': ['input'],
    \ })

    autocmd User DDCCmdlineLeave ++once call <SID>CommandlinePost()
    autocmd InsertEnter <buffer> ++once call <SID>CommandlinePost()

    call ddc#enable_cmdline_completion()
endfunction

function! s:CommandlinePost() abort
    silent! cunmap <Tab>
    silent! cunmap <S-Tab>
    silent! cunmap <C-n>
    silent! cunmap <C-p>
    silent! cunmap <C-y>
    silent! cunmap <C-e>

    if exists('b:prev_buffer_config')
      call ddc#custom#set_buffer(b:prev_buffer_config)
      unlet b:prev_buffer_config
    else
      call ddc#custom#set_buffer({})
    endif
endfunction

