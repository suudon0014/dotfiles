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

    -- create plugins list file using TOML format beforehand
    local rc_dir = vim.fn.expand('~/dotfiles/.vim/toml')
    local dein_toml        = rc_dir .. '/dein.toml'
    local lazy_toml        = rc_dir .. '/dein_lazy.toml'
    local ddc_toml         = rc_dir .. '/ddc_lazy.toml'
    local ddu_toml         = rc_dir .. '/ddu_lazy.toml'
    local dpp_toml         = rc_dir .. '/dpp_lazy.toml'
    local ai_toml          = rc_dir .. '/ai_lazy.toml'
    local colorscheme_toml = rc_dir .. '/colorscheme_lazy.toml'
    -- local lightline_toml   = rc_dir .. '/lightline_lazy.toml'
    local lualine_toml     = rc_dir .. '/lualine_lazy.toml'
    local markdown_toml    = rc_dir .. '/markdown_lazy.toml'
    local python_toml      = rc_dir .. '/python_lazy.toml'
    local treesitter_toml  = rc_dir .. '/treesitter_lazy.toml'

    -- read and cache the toml files
    dein.load_toml(dein_toml,        {lazy = false})
    dein.load_toml(lazy_toml,        {lazy = true})
    dein.load_toml(ddc_toml,         {lazy = true})
    dein.load_toml(ddu_toml,         {lazy = true})
    dein.load_toml(dpp_toml,         {lazy = true})
    dein.load_toml(ai_toml,          {lazy = true})
    dein.load_toml(colorscheme_toml, {lazy = true})
    dein.load_toml(lualine_toml,     {lazy = true})
    dein.load_toml(markdown_toml,    {lazy = true})
    dein.load_toml(python_toml,      {lazy = true})
    dein.load_toml(treesitter_toml,  {lazy = true})

    -- end the setting
    dein.end_()
    dein.save_state()
end

-- functions and commands
-- install if there are plugins not installed
vim.api.nvim_create_user_command('DeinInstall', function ()
    if dein.check_install() then
        dein.install()
    else
        vim.print('All plugins have already installed.')
    end
end, {})

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

vim.cmd.DeinInstall()

vim.api.nvim_create_autocmd({'VimEnter'}, {
    pattern = {'*'},
    callback = function ()
        dein.call_hook('post_source')
    end
})

