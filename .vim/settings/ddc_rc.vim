" configs about ddc.vim and pum.vim

" mappings
nnoremap : <Cmd>call CommandlinePre()<CR>:
inoremap <expr><Tab> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<Tab>'
inoremap <expr><S-Tab> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-Tab>'
inoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-e> <Cmd>call pum#map#cancel()<CR>
inoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'


" functions
function! CommandlinePre() abort
    cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y> <Cmd>call pum#map#confirm()<CR>
    cnoremap <C-e> <Cmd>call pum#map#cancel()<CR>
    cnoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR><CR>' : '<CR>'

    if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
    endif
    call ddc#custom#patch_buffer('cmdlineSources', ['cmdline', 'cmdline-history', 'around', 'file'])

    autocmd User DDCCmdlineLeave ++once call CommandlinePost()
    autocmd InsertEnter <buffer> ++once call CommandlinePost()

    call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
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


" patches
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('autoCompleteEvents',
    \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineEnter', 'CmdlineChanged']
\)
call ddc#custom#patch_global('sources', [
    \ 'vsnip',
    \ 'nvim-lsp',
    \ 'around',
    \ 'file',
    \ 'skkeleton',
    \ 'cmdline-history',
\ ])
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \     'matchers': ['matcher_fuzzy'],
    \     'sorters': ['sorter_fuzzy'],
    \     'converters': ['converter_fuzzy'],
    \     'ignoreCase' : v:true,
    \     'minAutoCompleteLength': 1,
    \ },
    \ 'nvim-lsp': {
    \     'mark': '[lsp]',
    \     'forceCompletionPattern': '\.|:|->|"\w*/*',
    \ },
    \ 'vsnip': {'mark': '[vsnip]', 'dup': v:true,},
    \ 'around': {'mark': '[around]'},
    \ 'file': {
    \     'mark': '[file]',
    \     'isVolatile': v:true,
    \     'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'skkeleton': {
    \   'mark': '[skk]',
    \   'matchers': ['skkeleton'],
    \   'sorters': [],
    \   'isVolatile': v:true,
    \ },
    \ 'cmdline-history': {
    \   'mark': '[cmdhist]',
    \ },
\ })

call ddc#custom#patch_global('sourceParams', {
    \ 'nvim-lsp': {
        \ 'kindLabels': {
            \ 'Text': " Text",
            \ 'Method': " Method",
            \ 'Function': " Function",
            \ 'Constructor': " Constructor",
            \ 'Field': " Field",
            \ 'Variable': " Variable",
            \ 'Class': "󿴯 Class",
            \ 'Interface': " Interface",
            \ 'Module': " Module",
            \ 'Property': " Property",
            \ 'Unit': " Unit",
            \ 'Value': " Value",
            \ 'Enum': " Enum",
            \ 'Keyword': " Keyword",
            \ 'Snippet': " Snippet",
            \ 'Color': " Color",
            \ 'File': "󿜘 File",
            \ 'Reference': "󿜆 Reference",
            \ 'Folder': " Folder",
            \ 'EnumMember': " EnumMember",
            \ 'Constant': "󿣾 Constant",
            \ 'Struct': "󿳼 Struct",
            \ 'Event': " Event",
            \ 'Operator': " Operator",
            \ 'TypeParameter': "󿞃 TypeParameter"
        \ }
    \ }
\ })

call ddc#custom#patch_global('backspaceCompletion', v:true)

call ddc#enable()

