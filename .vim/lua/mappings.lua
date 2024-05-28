vim.g.mapleader = " "

-- map jj to Esc
vim.keymap.set({'i', 'c'}, 'jj', '<Esc>', {silent = true})
vim.keymap.set({'i', 'c'}, 'j<Leader>', 'j', {silent = true})
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

-- Digraph search
vim.keymap.set('', '<Leader>f', 'f<C-k>')
local digraphs = vim.cmd.digraphs
digraphs('aa', 12354) -- あ
digraphs('ii', 12356) -- い
digraphs('uu', 12358) -- う
digraphs('ee', 12360) -- え
digraphs('oo', 12362) -- お
digraphs('AA', 12450) -- ア
digraphs('II', 12452) -- イ
digraphs('UU', 12454) -- ウ
digraphs('EE', 12456) -- エ
digraphs('OO', 12458) -- オ
digraphs('xa', 12353) -- ぁ
digraphs('xi', 12355) -- ぃ
digraphs('xu', 12357) -- ぅ
digraphs('xe', 12359) -- ぇ
digraphs('xo', 12361) -- ぉ
digraphs('xA', 12449) -- ァ
digraphs('xI', 12451) -- ィ
digraphs('xU', 12453) -- ゥ
digraphs('xE', 12455) -- ェ
digraphs('xO', 12457) -- ォ
digraphs(',,', 12289) -- 、
digraphs('..', 12290) -- 。

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
vim.keymap.set('', '<S-k>', 'k')
vim.keymap.set('n', '/', '/\\v')

vim.cmd('cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"')
