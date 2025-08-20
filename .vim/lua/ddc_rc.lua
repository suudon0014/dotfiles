-- configs about ddc.vim and pum.vim
vim.keymap.set('i', '<Tab>', function()
    if vim.fn['pum#visible']() then
        vim.fn['pum#map#insert_relative'](1)
    else
        local tab = vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
        vim.api.nvim_feedkeys(tab, 'n', false)
    end
end, {noremap = true})

vim.keymap.set('i', '<S-Tab>', function()
    if vim.fn['pum#visible']() then
        vim.fn['pum#map#insert_relative'](-1)
    else
        local stab = vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true)
        vim.api.nvim_feedkeys(stab, 'c', false)
    end
end, {noremap = true})

vim.keymap.set('i', '<C-n>', function() vim.fn['pum#map#insert_relative'](1) end, {noremap = true})
vim.keymap.set('i', '<C-p>', function() vim.fn['pum#map#insert_relative'](-1) end, {noremap = true})
vim.keymap.set('i', '<C-y>', vim.fn['pum#map#confirm'], {noremap = true})
vim.keymap.set('i', '<C-e>', vim.fn['pum#map#cancel'], {noremap = true})

vim.keymap.set('i', '<CR>', function()
    if vim.fn['pum#visible']() then
        vim.fn['pum#map#confirm']()
    else
        local cr = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
        vim.api.nvim_feedkeys(cr, 'n', false)
    end
end, {noremap = true})

-- functions
-- local function CommandlinePost()
--     pcall(vim.keymap.del, 'c', '<Tab>')
--     pcall(vim.keymap.del, 'c', '<S-Tab>')
--     pcall(vim.keymap.del, 'c', '<C-n>')
--     pcall(vim.keymap.del, 'c', '<C-p>')
--     pcall(vim.keymap.del, 'c', '<C-y>')
--     pcall(vim.keymap.del, 'c', '<C-e>')

--     if vim.b.prev_buffer_config ~= nil then
--         vim.fn['ddc#custom#set_buffer'](vim.b.prev_buffer_config)
--         vim.b.prev_buffer_config = nil
--     else
--         vim.fn['ddc#custom#set_buffer'](vim.empty_dict())
--     end
-- end

-- local function CommandlinePre()
--     local opts = {noremap = true, silent = true}
--     vim.keymap.set('c', '<Tab>', function() vim.fn['pum#map#insert_relative'](1) end, opts)
--     vim.keymap.set('c', '<S-Tab>', function() vim.fn['pum#map#insert_relative'](-1) end, opts)
--     vim.keymap.set('c', '<C-n>', function() vim.fn['pum#map#insert_relative'](1) end, opts)
--     vim.keymap.set('c', '<C-p>', function() vim.fn['pum#map#insert_relative'](-1) end, opts)
--     vim.keymap.set('c', '<C-y>', vim.fn['pum#map#confirm'], opts)
--     vim.keymap.set('c', '<C-e>', vim.fn['pum#map#cancel'], opts)
--     vim.keymap.set('c', '<CR>', function()
--         if vim.fn['pum#visible']() then
--             vim.fn['pum#map#confirm']()
--         else
--             vim.fn['kensaku_search#replace']()
--         end
--         local cr = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
--         vim.api.nvim_feedkeys(cr, 'c', false)
--     end, opts)

--     vim.b.prev_buffer_config = vim.fn['ddc#custom#get_buffer']()

--     vim.fn['ddc#custom#patch_buffer']('cmdlineSources', {
--         [':'] = {'cmdline', 'cmdline_history', 'around', 'file', 'path'},
--         ['@'] = {'input', 'cmdline_history', 'around', 'file', 'path'},
--         ['>'] = {'input', 'cmdline_history', 'around', 'file', 'path'},
--         ['/'] = {'around', 'line'},
--         ['?'] = {'around', 'line'},
--         ['-'] = {'around', 'line'},
--         ['='] = {'input'},
--     })

--     vim.api.nvim_create_autocmd({'User'}, {
--         pattern = {'DDCCmdlineLeave'},
--         once = true,
--         callback = CommandlinePost,
--     })
--     vim.api.nvim_create_autocmd({'InsertEnter'}, {
--         buffer = vim.fn.bufnr(),
--         once = true,
--         callback = CommandlinePost,
--     })

--     vim.fn['ddc#enable_cmdline_completion']()
-- end

-- mappings
-- vim.keymap.set({'n', 'x'}, ':', CommandlinePre, {noremap = true})

-- " patches
vim.fn['ddc#custom#patch_global']({
    ui = 'pum',
    autoCompleteEvents = {'InsertEnter', 'TextChangedI', 'TextChangedP', 'TextChangedT', 'CmdlineEnter', 'CmdlineChanged'},
    sources = {'vsnip', 'lsp', 'around', 'file', 'path', 'skkeleton', 'buffer', 'input'},
    sourceOptions = {
        ['_'] = {
            matchers = {'matcher_fuzzy'},
            sorters = {'sorter_fuzzy'},
            converters = {'converter_fuzzy'},
            ignoreCase = true,
            minAutoCompleteLength = 1,
            timeout = 1000,
        },
        lsp = {
            mark = '[LSP]',
            dup = 'keep',
            keywordPattern = '\\k+',
            forceCompletionPattern = '\\.\\w*|:\\w*|->\\w*',
            enabledIf = '!ddc#syntax#in("comment")',
            isVolatile = true,
        },
        vsnip = {mark = '[VSNIP]',},
        around = {mark = '[AROUND]'},
        file = {
            mark = '[FILE]',
            isVolatile = true,
            forceCompletionPattern = '\\S/\\S*'
        },
        path = {mark = '[PATH]',},
        skkeleton = {
          mark = '[SKK]',
          matchers = {},
          sorters = {},
          converters = {},
          isVolatile = true,
        },
        buffer = {mark = '[BUF]',},
        cmdline = {mark = '[C-LINE]',},
        cmdline_history = {mark = '[C-HIST]',},
        input = {
          mark = '[INP]',
          isVolatile = true,
        },
        shell_native = {mark = '[SHELL]',},
        ['shell-history'] = {
          mark = '[S-HIST]',
          minKeywordLength = 1,
          maxKeywordLength = 50,
        },
    },
    sourceParams = {
        lsp = {
          snippetEngine = vim.fn['denops#callback#register'](
              function(body) vim.fn['vsnip#anonymous'](body) end
          ),
          enableResolveItem = true,
          enableAdditionalTextEdit = true,
          confirmBehavior = 'replace',
        },
        file = {
          mode = 'posix',
        },
        path = {
          absolute = false,
          cmd = {'fd', '--max-depth', '5', '--hidden', '--exclude', '.git'},
          dirSeparator = 'slash',
        },
        buffer = {
          requireSameFiletype = false,
          bufNameStyle = 'basename',
        },
        ['shell-history'] = {
          command = {'zsh', '-c', 'history'},
        },
    },
    filterParams = {
        converter_kind_labels = {
            kindLabels = {
                Text = " Text",
                Method = " Method",
                Function = " Function",
                Constructor = " Constructor",
                Field = " Field",
                Variable = " Variable",
                Class = "󿴯 Class",
                Interface = " Interface",
                Module = " Module",
                Property = " Property",
                Unit = " Unit",
                Value = " Value",
                Enum = " Enum",
                Keyword = " Keyword",
                Snippet = " Snippet",
                Color = " Color",
                File = "󿜘 File",
                Reference = "󿜆 Reference",
                Folder = " Folder",
                EnumMember = " EnumMember",
                Constant = "󿣾 Constant",
                Struct = "󿳼 Struct",
                Event = " Event",
                Operator = " Operator",
                TypeParameter = "󿞃 TypeParameter"
            },
        },
    },
    backspaceCompletion = true,
})

-- terminal
vim.fn['ddc#enable_terminal_completion']()
vim.fn['ddc#custom#patch_filetype']({'deol'}, {
  specialBufferCompletion = true,
  sources = {'shell_native', 'shell-history', 'around'},
})

vim.fn['ddc#enable']({
    context_filetype = 'context_filetype',
})

