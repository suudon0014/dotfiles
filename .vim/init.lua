if vim.loader then vim.loader.enable() end

vim.cmd.filetype('off')
vim.cmd.filetype('plugin indent off')

-- load separated setting files
vim.opt.runtimepath:append('~/dotfiles/.vim/')
require('mappings')
require('sets')
-- require('extui')

require('dein_rc')
-- vim.cmd.source('~/dotfiles/.vim/settings/dpp_install.vim')
require('submode')

local myAuGroup = vim.api.nvim_create_augroup('myAuGroup', {})

local function should_save_view()
    local isNotBufEmpty = string.len(vim.fn.expand('%')) ~= 0
    local isNotNoFile = vim.bo.buftype ~= 'nofile'
    return isNotBufEmpty and isNotNoFile
end

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'?*'},
    callback = function ()
        if should_save_view() then
            vim.cmd.mkview({bang = true, mods = {emsg_silent = true}})
        end
    end,
    group = myAuGroup,
})
vim.api.nvim_create_autocmd({'BufRead'}, {
    pattern = {'?*'},
    callback = function ()
        if should_save_view() then
            vim.cmd.loadview({mods = {emsg_silent = true}})
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
vim.api.nvim_create_user_command('Path', function ()
    require('my_commands').show_path()
end, {})

vim.api.nvim_create_user_command('Profile', function ()
    require('my_commands').start_profile()
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

            vim.opt.guioptions:remove({'m', 'T', 'r', 'R', 'l', 'L', 'b'})
            end,
        once = true,
    })
end

