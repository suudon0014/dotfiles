" This function generates a program based on the selected text within Vim.
"
" It takes the start and end lines of the selection as input (a:from and a:to).
" It constructs a prompt for a large language model (LLM) that includes the filetype and the user-selected text as the program specification.
" The prompt instructs the LLM to generate the corresponding program code only, without any additional explanations.
" After the LLM generates the code, the function utilizes autocommands to bind control-y to copy the generated code and close the popup, and control-n to simply close the popup.
" Finally, it utilizes the GpPopup command to display the prompt to the LLM. 
function! GenerateAndReplaceProgram(from, to) abort
    let selectedStringArray = getline(a:from, a:to)
    let selectedStrings = join(selectedStringArray, "\n")
    let filetype = &filetype

    let prompt = "あなたは" . filetype . "のプログラムに精通した優秀なITエンジニアです。\n"
    let prompt = prompt . filetype . "で作成したいプログラムの仕様を以下に示すのでプログラムを作成してください。\n"
    let prompt = prompt . "ただし、説明文などは出力せず、生成したプログラムのソースコードのみ出力して下さい。\n\n"
    let prompt = prompt . "## プログラム仕様\n"
    let prompt = prompt . selectedStrings

    autocmd User GpDone ++once nnoremap <buffer> <C-y> <Cmd>execute('normal! ggVG"gy')<CR><Cmd>close<CR><Cmd>execute('normal! gv"ggp')<CR>
    autocmd User GpDone ++once nnoremap <buffer> <C-n> <Cmd>close<CR>
    execute "GpPopup" prompt
endfunction

command! -nargs=0 -range GenerateAndReplaceProgram call GenerateAndReplaceProgram(<line1>, <line2>)
vnoremap <C-g>gr :<C-u>'<,'>GenerateAndReplaceProgram<CR>

