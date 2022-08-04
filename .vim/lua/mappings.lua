vim.g.mapleader = " "

-- map jj to Esc
vim.keymap.set({'i', 'c'}, 'jj', '<Esc>', {silent = true})
vim.keymap.set({'i', 'c'}, 'ｊｊ', '<Esc>', {silent = true})
vim.keymap.set('t', 'jj', '<C-\\><C-n>', {silent = true})

-- key bindings of Space + another
vim.keymap.set('n', '<Leader>v', 'g0vg$h')
vim.keymap.set('n', '<Leader>d', 'g0vg$hx')
vim.keymap.set('n', '<Leader>y', 'g0vg$hy')

-- space + h/l : move to beginning/end of the line
vim.keymap.set('n', '<Leader>h', 'g^')
vim.keymap.set('n', '<Leader>l', 'g$')
vim.keymap.set('v', '<Leader>l', 'g$h')

-- move to the bracket counterpart
vim.keymap.set('n', '<Leader>b', '%')

-- command line mode
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
vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')
vim.keymap.set({'n', 'v'}, 'gj', 'j')
vim.keymap.set({'n', 'v'}, 'gk', 'k')
vim.keymap.set({'n', 'v'}, '<MiddleMouse>', '<Nop>')
vim.keymap.set({'n', 'v'}, '<2-MiddleMouse>', '<Nop>')
vim.keymap.set({'n', 'v'}, '<3-MiddleMouse>', '<Nop>')
vim.keymap.set({'n', 'v'}, '<4-MiddleMouse>', '<Nop>')
vim.keymap.set('t', '<S-Space>', '<Space>')
vim.keymap.set('n', '<S-k>', '<Nop>')
vim.keymap.set('n', '/', '/\\v')

vim.cmd('cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"')
