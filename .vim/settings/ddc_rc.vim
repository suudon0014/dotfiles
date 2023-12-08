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
    call ddc#custom#patch_buffer('cmdlineSources', {
        \ ':': ['cmdline', 'cmdline-history', 'around', 'file', 'path'],
        \ '@': ['input', 'cmdline-history', 'around', 'file', 'path'],
        \ '>': ['input', 'cmdline-history', 'around', 'file', 'path'],
        \ '/': ['around', 'line'],
        \ '?': ['around', 'line'],
        \ '-': ['around', 'line'],
        \ '=': ['input'],
    \ })

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
call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('autoCompleteEvents',
    \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'TextChangedT', 'CmdlineEnter', 'CmdlineChanged']
\)
call ddc#custom#patch_global('sources', [
    \ 'vsnip',
    \ 'lsp',
    \ 'around',
    \ 'file',
    \ 'path',
    \ 'skkeleton',
    \ 'buffer',
    \ 'cmdline-history',
    \ 'input',
\ ])
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \     'matchers': ['matcher_fuzzy'],
    \     'sorters': ['sorter_fuzzy'],
    \     'converters': ['converter_fuzzy'],
    \     'ignoreCase' : v:true,
    \     'minAutoCompleteLength': 1,
    \ },
    \ 'lsp': #{
    \     mark: '[LSP]',
    \     dup: 'keep',
    \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
    \ },
    \ 'vsnip': {'mark': '[VSNIP]',},
    \ 'around': {'mark': '[AROUND]'},
    \ 'file': {
    \     'mark': '[FILE]',
    \     'isVolatile': v:true,
    \     'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'path': {
    \     'mark': '[PATH]',
    \ },
    \ 'skkeleton': {
    \   'mark': '[SKK]',
    \   'matchers': [],
    \   'sorters': [],
    \   'converters': [],
    \   'isVolatile': v:true,
    \ },
    \ 'buffer': {
    \   'mark': '[BUF]',
    \ },
    \ 'cmdline': {
    \   'mark': '[C-LINE]',
    \ },
    \ 'cmdline-history': {
    \   'mark': '[C-HIST]',
    \ },
    \ 'input': {
    \   'mark': '[INP]',
    \   'isVolatile': v:true,
    \ },
    \ 'zsh': {
    \   'mark': '[ZSH]',
    \ },
    \ 'shell-history': {
    \   'mark': '[S-HIST]',
    \   'minKeywordLength': 1,
    \   'maxKeywordLength': 50,
    \ },
\ })

call ddc#custom#patch_global('sourceParams', {
    \ 'lsp': #{
    \   snippetEngine: denops#callback#register({body -> vsnip#anonymous(body)}),
    \   enableResolveItem: v:true,
    \   enableAdditionalTextEdit: v:true,
    \   confirmBehavior: 'replace',
    \ },
    \ 'file': {
    \   'mode': 'posix',
    \ },
    \ 'path': {
    \   'absolute': v:false,
    \   'cmd': ['fd', '--max-depth', '5', '--hidden', '--exclude', '.git'],
    \   'dirSeparator': 'slash',
    \ },
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'bufNameStyle': "basename",
    \ },
    \ 'shell-history': {
    \   'command': ['zsh', '-c', 'history'],
    \ },
\ })

call ddc#custom#patch_global(#{
    \ filterParams: #{
        \ converter_kind_labels: #{
            \ kindLabels: #{
                \ Text: " Text",
                \ Method: " Method",
                \ Function: " Function",
                \ Constructor: " Constructor",
                \ Field: " Field",
                \ Variable: " Variable",
                \ Class: "󿴯 Class",
                \ Interface: " Interface",
                \ Module: " Module",
                \ Property: " Property",
                \ Unit: " Unit",
                \ Value: " Value",
                \ Enum: " Enum",
                \ Keyword: " Keyword",
                \ Snippet: " Snippet",
                \ Color: " Color",
                \ File: "󿜘 File",
                \ Reference: "󿜆 Reference",
                \ Folder: " Folder",
                \ EnumMember: " EnumMember",
                \ Constant: "󿣾 Constant",
                \ Struct: "󿳼 Struct",
                \ Event: " Event",
                \ Operator: " Operator",
                \ TypeParameter: "󿞃 TypeParameter"
            \ },
        \ }
    \ }
\ })

call ddc#custom#patch_global('backspaceCompletion', v:true)

" Obsidian
function! Obsidian() abort
    call ddc#custom#patch_buffer('sources', ['nvim-obsidian', 'nvim-obsidian-new'])
    call ddc#custom#patch_buffer('sourceOptions', #{
    \   nvim-obsidian: #{
    \       mark: '[OBS]',
    \ },
    \   nvim-obsidian-new: #{
    \       mark: '[OBS+]',
    \ }})
    call ddc#custom#patch_buffer('sourceParams', #{
    \   nvim-obsidian: #{
    \       dir: '~/obsidian_vault',
    \   },
    \   nvim-obsidian-new: #{
    \       dir: '~/obsidian_vault',
    \ }})
endfunction
autocmd BufEnter,BufNewFile ~/obsidian_vault/**/*.md call Obsidian()

" terminal
call ddc#enable_terminal_completion()
call ddc#custom#patch_filetype(['deol'], #{
\   specialBufferCompletion: v:true,
\   keywordPattern: '[0-9a-zA-Z_./#:-]*',
\   sources: ['zsh', 'shell-history', 'around'],
\ })


call ddc#enable( #{
    \ context_filetype: "context_filetype",
\ })

