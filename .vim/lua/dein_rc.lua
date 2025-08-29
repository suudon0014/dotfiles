-- configs about dein.vim

-- installing directory
local dein_dir = vim.fn.expand('~/.cache/dein')

-- global parameters
vim.g['dein#install_github_api_token'] = os.getenv('GITHUB_API_TOKEN')
vim.g['dein#install_max_processes'] = 32
vim.g['dein#install_process_timeout'] = 1800
vim.g['dein#install_progress_type'] = 'floating'
vim.g['dein#types#git#clone_depth'] = 1
vim.g['dein#install_log_filename'] = dein_dir .. '/install_log.log'

-- dir of dein.vim
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'

-- download dein.vim if there's no dein.vim
if not string.match(vim.api.nvim_eval('&runtimepath'), '/dein.vim') then
    if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
        vim.print('Cloning dein.vim repository start.')
        local job = vim.system({'git', 'clone', 'https://github.com/Shougo/dein.vim', dein_repo_dir}, {text = true}):wait()
        if job.code == 0 then
            vim.print('Cloning completed.')
        else
            vim.print('Cloning failed.')
        end
    end
    vim.opt.runtimepath:prepend(dein_repo_dir)
end

-- dein.vim settings
local dein = require('dein')
if dein.load_state(dein_dir) == 1 then
    dein.begin(dein_dir)

    local function load_toml_files(toml_names, is_lazy)
        for _, name in ipairs(toml_names) do
            local toml_file = vim.fn.expand('~/dotfiles/.vim/toml/') .. "" .. name .. ".toml"
            if vim.fn.filereadable(toml_file) == 1 then
                dein.load_toml(toml_file, {lazy = is_lazy})
            end
        end
    end

    load_toml_files({'dein'}, false)
    load_toml_files({'dein_lazy', 'ddc_lazy', 'ddu_lazy', 'ai_lazy', 'colorscheme_lazy', 'lualine_lazy', 'markdown_lazy', 'python_lazy', 'treesitter_lazy'}, true)
    -- 'dpp.lazy', 'lightline_lazy'

    -- end the setting
    dein.end_()
    dein.save_state()
end

-- install if there are plugins not installed
if dein.check_install() then
    dein.install()
end

-- functions and commands
-- work only when delete plugins
vim.api.nvim_create_user_command('DeinClean', function ()
    local disabled_plugins = dein.check_clean()
    if #disabled_plugins > 0 then
        vim.print('Processing...')
        for _, p in ipairs(disabled_plugins) do
            vim.fs.rm(p, {recursive = true, force = true})
        end
        vim.print('DeinClean completed.')
    else
        vim.print("There's no disabled plugins.")
    end
end, {})

-- update plugins using Github GraphQL API
vim.api.nvim_create_user_command('DeinUpdate', function ()
    if vim.g['dein#install_github_api_token'] ~= nil then
        dein.check_update(true)
        vim.print('DeinUpdate completed.')
        vim.print(dein.get_updates_log())
    else
        vim.print('[Error] Set $GITHUB_API_TOKEN and restart vim for DeinUpdate to work.')
    end
end, {})

-- update all plugins strictly but slower than :DeinUpdate
vim.api.nvim_create_user_command('DeinStrictUpdate', function ()
    dein.update()
    vim.print(dein.get_updates_log())
end, {})

vim.api.nvim_create_autocmd({'VimEnter'}, {
    pattern = {'*'},
    callback = function ()
        dein.call_hook('post_source')
    end
})

