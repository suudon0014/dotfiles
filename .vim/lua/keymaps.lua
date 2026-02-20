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
local digraphs_list = {
    {'aa', 12354}, -- あ
    {'ii', 12356}, -- い
    {'uu', 12358}, -- う
    {'ee', 12360}, -- え
    {'oo', 12362}, -- お
    {'AA', 12450}, -- ア
    {'II', 12452}, -- イ
    {'UU', 12454}, -- ウ
    {'EE', 12456}, -- エ
    {'OO', 12458}, -- オ
    {'xa', 12353}, -- ぁ
    {'xi', 12355}, -- ぃ
    {'xu', 12357}, -- ぅ
    {'xe', 12359}, -- ぇ
    {'xo', 12361}, -- ぉ
    {'xA', 12449}, -- ァ
    {'xI', 12451}, -- ィ
    {'xU', 12453}, -- ゥ
    {'xE', 12455}, -- ェ
    {'xO', 12457}, -- ォ
    {',,', 12289}, -- 、
    {'..', 12290}, -- 。
}

for _, d in ipairs(digraphs_list) do
    vim.cmd.digraphs(d[1], d[2])
end

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

-- swap a" and 2i"
for _, quote in pairs({'"', "'", '`'}) do
    vim.keymap.set({'x', 'o'}, "a" .. quote, "2i" .. quote)
end

for _, quote in pairs({'"', "'", '`'}) do
    vim.keymap.set({'x', 'o'}, "2i" .. quote, "a" .. quote)
end

-- change uppercase and lower case
vim.keymap.set('i', '<C-g><C-u>', '<Esc>gUiwgi')
vim.keymap.set('i', '<C-g><C-l>', '<Esc>guiwgi')
vim.keymap.set('i', '<C-g><C-k>', '<Esc>bgUlgi')

-- paste adjust indents
vim.keymap.set('n', 'p', ']p')
vim.keymap.set('n', 'P', ']P')

-- etc.
-- j,k -> gj,gk
vim.keymap.set({'n', 'x'}, 'j', function ()
    return vim.v.count == 0 and 'gj' or 'j'
end, {expr = true, silent = true})
vim.keymap.set({'n', 'x'}, 'k', function ()
    return vim.v.count == 0 and 'gk' or 'k'
end, {expr = true, silent = true})

vim.keymap.set('', '<MiddleMouse>', '<Nop>')
vim.keymap.set('', '<2-MiddleMouse>', '<Nop>')
vim.keymap.set('', '<3-MiddleMouse>', '<Nop>')
vim.keymap.set('', '<4-MiddleMouse>', '<Nop>')
vim.keymap.set('t', '<S-Space>', '<Space>')
vim.keymap.set('', '<S-k>', 'k')
vim.keymap.set('n', '/', '/\\v')

vim.keymap.set('ca', 'w]', function()
    if (vim.fn.getcmdtype() == ':') and (vim.fn.getcmdline() == 'w]') then
        return 'w'
    else
        return 'w]'
    end
end, {expr = true})
