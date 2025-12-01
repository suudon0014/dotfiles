-- manipulations for window

local function nmap(lhs, rhs) vim.keymap.set('n', lhs, rhs, {remap = true}) end
local function nnoremap_script(lhs, rhs) vim.keymap.set('n', lhs, rhs, {noremap = true, script = true}) end

local mappings = {
    {'j', '<C-w>j'},
    {'k', '<C-w>k'},
    {'l', '<C-w>l'},
    {'h', '<C-w>h'},
    {'J', '<C-w>J'},
    {'K', '<C-w>K'},
    {'L', '<C-w>L'},
    {'H', '<C-w>H'},
    {'w', '<C-w>w'},
    {'s', ':<C-u>sp<CR>'},
    {'v', ':<C-u>vs<CR>'},
    {'q', ':<C-u>q<CR>'},
    {';', '<C-w>+'},
    {'-', '<C-w>-'},
    {',', '<C-w><'},
    {'.', '<C-w>>'},
    {'=', '<C-w>='},
    {'O', '<C-w>='},
    {'o', ':<C-u>vertical res<CR><C-w>_'},
    {'Q', ':<C-u>bd<CR>'},
    {'c', ':<C-u>only<CR>'},
    {'t', ':<C-u>tabnew<CR>'},
    {'n', 'gt'},
    {'p', 'gT'},
    {'e', '<Nop>', stop = true},
    -- disable sr to avoid conflict with vim-sandwich
    {'r', '<C-w>r', disable_nmap = true},
    {'R', '<C-w>R'},
}

for _, map in ipairs(mappings) do
    local key, action = map[1], map[2]

    local suffix = '<SID>ws'
    if map.stop then
        suffix = ''
    end

    if not map.disable_nmap then
        nmap('s' .. key, action .. suffix)
    end
    nnoremap_script('<SID>ws' .. key, action .. suffix)
end

nnoremap_script('<SID>ws', '<Nop>')
nmap('<SID>w', '<Nop>')
