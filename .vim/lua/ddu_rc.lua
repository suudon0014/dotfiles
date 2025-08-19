-- configs about ddu.vim
-- functions and commands
local function set_ddu_win_pos()
    ddu_win_pos = {
        winWidth  = math.floor(vim.o.columns * 0.9),
        winCol    = math.floor(vim.o.columns * 0.05),
        winHeight = math.floor(vim.o.lines * 0.6),
        winRow    = math.floor(vim.o.lines * 0.2),
    }
end

local function set_ddu_win_and_preview_pos()
    ddu_win_and_preview_pos = {
        winWidth      = math.floor(vim.o.columns * 0.45),
        winCol        = math.floor(vim.o.columns * 0.05),
        winHeight     = math.floor(vim.o.lines * 0.6),
        winRow        = math.floor(vim.o.lines * 0.2),
        previewWidth  = math.floor(vim.o.columns * 0.45),
        previewCol    = math.floor(vim.o.columns * 0.5),
        previewHeight = math.floor(vim.o.lines * 0.6),
        previewRow    = math.floor(vim.o.lines * 0.2),
    }
end

local AutoResizeDduWinPos = vim.api.nvim_create_augroup('AutoResizeDduWinPos', {})
vim.api.nvim_create_autocmd({'VimEnter', 'VimResized'}, {
    pattern = {'*'},
    callback = function ()
        set_ddu_win_pos()
        set_ddu_win_and_preview_pos()
    end,
    group = AutoResizeDduWinPos
})

local function DduStart(source, preview_enable, custom_enable, floating_title)
    local ui_params = nil
    if preview_enable then
        ui_params = ddu_win_and_preview_pos
    else
        ui_params = ddu_win_pos
    end

    ui_params.floatingTitle = floating_title

    if custom_enable then
        vim.fn['ddu#start']({
            name = source,
            uiParams = {ff = ui_params},
        })
    else
        vim.fn['ddu#start']({
            sources = {{name = source}},
            uiParams = {ff = ui_params},
        })
    end
end

-- mappings
vim.keymap.set('n', ',<Leader>', ',', {noremap = true, silent = true})
vim.keymap.set('n', ',ff', function() DduStart('file_rec', true, false, {{'[FILE]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'file_rec'})
vim.keymap.set('n', ',l',  function() DduStart('line', true, false, {{'[LINE]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'line'})
vim.keymap.set('n', ',b',  function() DduStart('buffer', true, false, {{'[BUFFER]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'buffer'})
vim.keymap.set('n', ',c', function() DduStart('command_history', false, false, {{'[CMD_HIST]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'command_history'})
vim.keymap.set('n', ',C', function() DduStart('colorscheme', false, false, {{'[COLORSCHEME]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'colorscheme'})
vim.keymap.set('n', ',H', function() DduStart('help', true, false, {{'[HELP]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'help'})
vim.keymap.set('n', ',d', function() DduStart('dirmark_custom', false, true, {{'[DIRMARK]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'dirmark_custom'})
vim.keymap.set('n', ',ma', function() DduStart('marks', true, false, {{'[MARKS]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'marks'})
vim.keymap.set('n', ',mr', function() DduStart('mr', true, false, {{'[MR]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'mr'})
vim.keymap.set('n', ',u', function() DduStart('dein_update', false, false, {{'[DEIN]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'dein_update'})
vim.keymap.set('n', ',gd', function() DduStart('git_diff', true, false, {{'[GIT_DIFF]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'git_diff'})
vim.keymap.set('n', ',gr', function() DduStart('git_ref', true, false, {{'[GIT_SHOW_REF]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'git_ref'})
vim.keymap.set('n', ',gs', function() DduStart('git_status', true, false, {{'[GIT_STATUS]', 'Blue'}}) end, {noremap = true, silent = true, desc = 'git_status'})

local function DduGrep(...)
    local volatile = false
    local word = ''
    local paramLength = select('#', ...)
    if paramLength == 0 then
        volatile = true
    elseif paramLength == 1 then
        word = (select(1, ...))
    elseif paramLength == 2 then
        word = (select(1, ...))
        volatile = (select(2, ...))
    end

    local ui_params = ddu_win_and_preview_pos
    ui_params.floatingTitle = {{'[GREP]', 'Blue'}}
    vim.fn['ddu#start']({
      uiParams = {ff = ui_params},
      sources = {{
        name = 'rg',
        params = {input = word},
        options = {volatile = volatile},
      }}
    })
end

local function DduGrepCWord()
    DduGrep(vim.fn.expand('<cword>'))
end

vim.api.nvim_create_user_command('DduGrep', function(params) DduGrep(params.fargs[1]) end, {nargs = '*', bang = true})
vim.keymap.set('n', ',rw', ':DduGrep<Space>', {noremap = true, silent = true, desc = 'grep'})
vim.keymap.set('n', ',rl', function() DduGrep('', true) end, {noremap = true, silent = true, desc = 'grep(real time)'})
vim.keymap.set('n', ',ra', DduGrepCWord, {noremap = true, silent = true, desc = 'grep(cursor)'})

local function DduFilerSingleStart()
    local ui_params = ddu_win_and_preview_pos
    vim.fn['ddu#start']({
        name = 'filer_single',
        uiParams = {filer = ui_params,},
        sources = {{
            name = 'file',
            options = {
                columns = {'icon_filename'},
                path = vim.fn.getcwd(),
                converters = {'converter_file_info'},
            },
        }},
    })
end
vim.keymap.set('n', ',fs', DduFilerSingleStart, {noremap = true, silent = true, desc = 'filer(single)'})

local function DduFilerDualStart()
    local win_and_preview_pos = ddu_win_and_preview_pos

    local ui_params_left = {
        winWidth  = win_and_preview_pos.winWidth,
        winCol    = win_and_preview_pos.winCol,
        winHeight = win_and_preview_pos.winHeight,
        winRow    = win_and_preview_pos.winRow,
    }
    local ui_params_right = {
        winWidth  = win_and_preview_pos.previewWidth,
        winCol    = win_and_preview_pos.previewCol,
        winHeight = win_and_preview_pos.previewHeight,
        winRow    = win_and_preview_pos.previewRow,
    }

    vim.fn['ddu#start']({
        name = 'filer_dual_right',
        uiParams = {filer = ui_params_right,},
        sources = {{
            name = 'file',
            options = {
                columns = {'icon_filename'},
                path = vim.fn.getcwd(),
            },
        }},
    })
    vim.fn['ddu#start']({
        name = 'filer_dual_left',
        uiParams = {filer = ui_params_left,},
        sources = {{
            name = 'file',
            options = {
                columns = {'icon_filename'},
                path = vim.fn.getcwd(),
            },
        }},
    })
end
vim.keymap.set('n', ',fd', DduFilerDualStart, {noremap = true, silent = true, desc = 'filer(dual)'})

local function DduFilerSideBarStart()
    vim.fn['ddu#start']({
        name = 'filer_side_bar',
        sources = {{
            name = 'file',
            options = {
                columns = {'icon_filename'},
                path = vim.fn.getcwd(),
            },
        }},
    })
end
vim.keymap.set('n', ',t', DduFilerSideBarStart, {noremap = true, silent = true, desc = 'filer(sidebar)'})

-- patches
vim.fn['ddu#custom#patch_global']({
    ui = 'ff',
    uiParams = {
        ff = {
            split                 = 'floating',
            floatingBorder        = 'single',
            winHeight             = 20,
            winWidth              = vim.o.columns / 2,
            previewHeight         = 20,
            previewWidth          = vim.o.columns / 2,
            previewFloating       = true,
            previewFloatingBorder = 'single',
            previewSplit          = 'vertical',
            reversed              = false,
            maxDisplayItems       = 10000,
        },
        filer = {
            split                 = 'floating',
            sort                  = 'filename',
            sortTreesFirst        = true,
            floatingBorder        = 'single',
            previewHeight         = 20,
            previewWidth          = vim.o.columns / 2,
            previewFloating       = true,
            previewFloatingBorder = 'single',
            previewSplit          = 'vertical',
            previewFloatingZindex = 100,
        },
    },
    sourceParams = {
        file_rec = {
            ignoredDirectories = {'.git', '.cache', '.clangd', '.vs', '.obsidian', '.obsidian_win', '.obsidian_android', '.trash'},
        },
        rg = {
            args = {'--column', '--no-heading', '--no-ignore', '--glob', '!.git/', '--hidden', '--color', 'never', '--smart-case', '--json'},
            highlights = {
                path = 'Identifier',
                lineNr = 'Comment',
                word = 'Constant',
            },
        },
        help = {
            helpLang = 'ja,en',
        },
        dein_update = {
            maxProcess = 32,
            useGraphQL = false,
        },
    },
    sourceOptions = {
        ['_'] = {
            matchers = {'matcher_fzf'},
            sorters = {'sorter_fzf'},
        },
        dirmark = {
            defaultAction = 'cd',
        },
        dein_update = {
            matchers = {'matcher_dein_update', 'matcher_fzf'},
        },
        file_rec = {
            converters = {{name = 'converter_hl_dir'}},
        },
    },
    kindOptions = {
        file            = {defaultAction = 'open',},
        action          = {defaultAction = 'do',},
        command_history = {defaultAction = 'execute',},
        colorscheme     = {defaultAction = 'set',},
        help            = {defaultAction = 'vsplit',},
        dein_update     = {defaultAction = 'viewDiff',},
        git_tag         = {defaultAction = 'switch',},
        git_branch      = {defaultAction = 'switch',},
        lsp             = {defaultAction = 'open',},
        lsp_codeAction  = {defaultAction = 'apply',},
    },
    actionOptions = {
        narrow   = {quit = false,},
        cd       = {quit = false,},
        dirmark  = {quit = false,},
        echo     = {quit = false,},
        echoDiff = {quit = false,},
    },
    filterParams = {
        matcher_fzf = {highlightMatched = 'Search',},
    },
    columnParams = {
        filename = {
            collapsedIcon = '\\ue5ff',
            expandedIcon = '\\ue5fe',
        },
        -- icon_filename = {
        --     defaultIcon = {icon = '\\uf016',},
        -- },
    },
})

vim.fn['ddu#custom#patch_local']('dirmark_custom', {
    sources = {{name = 'dirmark'}},
    actionOptions = {
        cd = {quit = true,},
    },
})

vim.fn['ddu#custom#patch_local']('filer_single', {ui = 'filer',})
vim.fn['ddu#custom#patch_local']('filer_dual_left', {ui = 'filer',})
vim.fn['ddu#custom#patch_local']('filer_dual_right', {ui = 'filer',})

vim.fn['ddu#custom#patch_local']('filer_side_bar', {
    ui = 'filer',
    uiParams = {
        filer = {
            split = 'vertical',
            splitDirection = 'topleft',
            winWidth = 30,
        },
    },
    uiOptions = {
        filer = {toggle = true,}},
})
