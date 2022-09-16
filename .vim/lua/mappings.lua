vim.g.mapleader = " "

-- map jj to Esc
vim.keymap.set({'i', 'c'}, 'jj', '<Esc>', {silent = true})
vim.keymap.set({'i', 'c'}, 'ｊｊ', '<Esc>', {silent = true})
vim.keymap.set('t', 'jj', '<C-\\><C-n>', {silent = true})

-- key bindings of Space + another
vim.keymap.set('', '<Leader>v', 'g0vg$h')
vim.keymap.set('', '<Leader>d', 'g0vg$hx')
vim.keymap.set('', '<Leader>y', 'g0vg$hy')

-- space + h/l : move to beginning/end of the line
vim.keymap.set('', '<Leader>h', 'g^')
vim.keymap.set('', '<Leader>l', 'g$')
vim.keymap.set('v', '<Leader>l', 'g$h')

-- move to the bracket counterpart
vim.keymap.set('', '<Leader>b', '%')

-- command line mode
vim.keymap.set('c', '<C-b>', '<Up>')
vim.keymap.set('c', '<C-f>', '<Down>')
vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-Space>h', '<Home>')
vim.keymap.set('c', '<C-Space><C-h>', '<Home>')
vim.keymap.set('c', '<C-Space>l', '<End>')
vim.keymap.set('c', '<C-Space><C-l>', '<End>')
vim.keymap.set('c', '<C-d>', '<Del>')

-- quickfix and locationlist
vim.keymap.set('n', '[q', ':cprevious<CR>')
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[l', ':lprevious<CR>')
vim.keymap.set('n', ']l', ':lnext<CR>')
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"qf"},
    callback = function()
        vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, silent = true })
        vim.keymap.set('n', '+', '<C-w>+', { buffer = true, silent = true })
        vim.keymap.set('n', ';', '<C-w>+', { buffer = true, silent = true })
        vim.keymap.set('n', '-', '<C-w>-', { buffer = true, silent = true })
        vim.keymap.set('n', 'p', '<CR><C-w>j', { buffer = true, silent = true })
        vim.keymap.set('n', 'j', 'j', { buffer = true })
        vim.keymap.set('n', 'k', 'k', { buffer = true })
        vim.keymap.set('n', 'gj', 'gj', { buffer = true })
        vim.keymap.set('n', 'gk', 'gk', { buffer = true })
    end,
})

-- buffer
vim.keymap.set('n', 'sN', ':<C-u>bn<CR>')
vim.keymap.set('n', 'sP', ':<C-u>bp<CR>')

-- etc.
vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', 'k', 'gk')
vim.keymap.set('', 'gj', 'j')
vim.keymap.set('', 'gk', 'k')
vim.keymap.set('', '<MiddleMouse>', '<Nop>')
vim.keymap.set('', '<2-MiddleMouse>', '<Nop>')
vim.keymap.set('', '<3-MiddleMouse>', '<Nop>')
vim.keymap.set('', '<4-MiddleMouse>', '<Nop>')
vim.keymap.set('t', '<S-Space>', '<Space>')
vim.keymap.set('n', '<S-k>', '<Nop>')
vim.keymap.set('n', '/', '/\\v')

vim.cmd('cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"')
