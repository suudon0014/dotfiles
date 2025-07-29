if vim.loader then vim.loader.enable() end

vim.cmd.filetype('off')
vim.cmd.filetype('plugin indent off')

-- load separated setting files
vim.opt.runtimepath:append('~/dotfiles/.vim/')
vim.cmd.runtime({args = {'lua/mappings.lua'}, bang = true})
vim.cmd.runtime({args = {'lua/sets.lua'}, bang = true})
-- vim.cmd.runtime({args = {'lua/extui.lua'}, bang = true})

vim.cmd.source('~/dotfiles/.vim/dein_rc.lua')
-- vim.cmd.source('~/dotfiles/.vim/settings/dpp_install.vim')
vim.cmd.source('~/dotfiles/.vim/settings/submode.vim')
-- require('submode')

local myAuGroup = vim.api.nvim_create_augroup('myAuGroup', {})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'?*'},
    callback = function ()
        local isNotBufEmpty = string.len(vim.fn.expand('%')) ~= 0
        local isNotNoFile = vim.bo.buftype ~= 'nofile'
        if isNotBufEmpty and isNotNoFile then
            vim.cmd('silent! mkview!')
        end
    end,
    group = myAuGroup,
})
vim.api.nvim_create_autocmd({'BufRead'}, {
    pattern = {'?*'},
    callback = function ()
        local isNotBufEmpty = string.len(vim.fn.expand('%')) ~= 0
        local isNotNoFile = vim.bo.buftype ~= 'nofile'
        if isNotBufEmpty and isNotNoFile then
            vim.cmd('silent! loadview')
        end
    end,
    group = myAuGroup,
})
vim.api.nvim_create_autocmd({'QuickFixCmdPost'}, {
    pattern = {'*grep*'},
    callback = function () vim.cmd.cwindow() end,
    group = myAuGroup,
})
vim.api.nvim_create_autocmd({'VimLeave'}, {
    pattern = {'*'},
    callback = function ()
        vim.cmd.mksession({args = {'~/session.vim'}, bang = true})
    end,
    group = myAuGroup,
})

-- show full path
vim.api.nvim_create_user_command('Path', function () print(vim.fn.expand('%:p')) end, {})

vim.api.nvim_create_user_command('Profile', function ()
    vim.cmd.profile('start ~/profile.txt')
    vim.cmd.profile('func *')
    vim.cmd.profile('file *')
end, {})

vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')

-- Gui
if vim.fn.has('gui_running') == 1 then
    vim.api.nvim_create_autocmd('GUIEnter', {
        pattern = '*',
        callback = function()
            if vim.fn.has('win32') == 1 or vim.fn.has('win64') then
                vim.cmd.source(os.getenv('VIMRUNTIME') .. '/delmenu.vim')
                vim.opt.langmenu = 'ja_jp.utf-8'
                vim.cmd.source(os.getenv('VIMRUNTIME') .. '/menu.vim')
            end

            if vim.fn.has('nvim') == 1 then
                vim.cmd.GuiFont({args = {'Cica:h11'}, bang = true})
                vim.cmd.GuiPopupmenu(0)
                vim.cmd.GuiTabline(0)
            end

            vim.opt.guioptions:remove('m')
            vim.opt.guioptions:remove('T')
            vim.opt.guioptions:remove('r')
            vim.opt.guioptions:remove('R')
            vim.opt.guioptions:remove('l')
            vim.opt.guioptions:remove('L')
            vim.opt.guioptions:remove('b')
            end,
        once = true,
    })
end

