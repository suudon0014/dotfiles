if vim.loader then vim.loader.enable() end

vim.cmd.filetype('off')
vim.cmd.filetype('plugin indent off')

-- load separated setting files
-- [Temporary] 移行期間中のモジュール読み込みエラー回避のためのワークアラウンド。
-- lazy.nvimへの一本化完了後、ディレクトリ構成が整理されれば削除可能。
local dotfiles_path = vim.fn.expand('~/dotfiles/.vim')
vim.opt.runtimepath:prepend(dotfiles_path)
package.path = package.path .. ';' .. dotfiles_path .. '/lua/?.lua'
require('keymaps')
require('options')
-- require('extui')

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    "plugins",
    {
        concurrency = 16,
        change_detection = { enabled = false, },
    }
)

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
    require('commands').show_path()
end, {})

vim.api.nvim_create_user_command('Profile', function ()
    require('commands').start_profile()
end, {})

vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')

-- Gui
if vim.fn.has('gui_running') == 1 then
    vim.api.nvim_create_autocmd('GUIEnter', {
        pattern = '*',
        callback = function()
            if vim.fn.has('win32') == 1 or vim.fn.has('win64') then
                vim.cmd.source(vim.fs.normalize(vim.fs.joinpath(os.getenv('VIMRUNTIME'), 'delmenu.vim')))
                vim.opt.langmenu = 'ja_jp.utf-8'
                vim.cmd.source(vim.fs.normalize(vim.fs.joinpath(os.getenv('VIMRUNTIME'), 'menu.vim')))
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

