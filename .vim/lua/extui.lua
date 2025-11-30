vim.opt.cmdheight = 0

local extui = require('vim._extui')
extui.enable({
    enable = true,
    msg = {
        pos = 'cmd',
        box = {
            timeout = 5000,
        }
    }
})

-- macro
local extui_recording_group = vim.api.nvim_create_augroup('extuiRecordingGroup', {})
vim.api.nvim_create_autocmd('RecordingEnter',{
    callback = function ()
        local msg = string.format("Macro Record Start[%s]", vim.fn.reg_recording())
        vim.notify(msg, vim.log.levels.INFO)
    end,
    group = extui_recording_group,
})

vim.api.nvim_create_autocmd('RecordingLeave',{
    callback = function ()
        local msg = string.format("Macro Record End[%s]", vim.fn.reg_recording())
        vim.notify(msg, vim.log.levels.INFO)
    end,
    group = extui_recording_group,
})

-- colorscheme
local extui_colorscheme = 'terafox'
local extui_augroup = vim.api.nvim_create_augroup('extuiAuGroup', {})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = extui_augroup,
    callback = function ()
        local extui_shared = require('vim._extui.shared')
        if not extui_shared.cfg.enable then
            return
        end
        local tabpage = vim.api.nvim_get_current_tabpage()
        local extuiwin = extui_shared.wins[tabpage]
        for _, w in pairs(extuiwin) do
            require('styler').set_theme(w, {
                colorscheme = extui_colorscheme
            })
        end
    end
})

