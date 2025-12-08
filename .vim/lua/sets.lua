-- set backup folders
local state_dir  = vim.fn.stdpath('state')
local undo_dir   = state_dir .. '/undo'
local backup_dir = state_dir .. '/backup'
local swap_dir   = state_dir .. '/swap'

if vim.fn.isdirectory(undo_dir)   == 0 then vim.fn.mkdir(undo_dir, 'p') end
if vim.fn.isdirectory(backup_dir) == 0 then vim.fn.mkdir(backup_dir, 'p') end
if vim.fn.isdirectory(swap_dir)   == 0 then vim.fn.mkdir(swap_dir, 'p') end

vim.opt.undodir   = undo_dir
vim.opt.backupdir = backup_dir
vim.opt.directory = swap_dir

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.autoread = true

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tab
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- command line mode
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- folding
vim.opt.foldmethod = 'manual'
vim.opt.foldcolumn = '1'

-- encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,sjis'
vim.opt.fileformats = 'unix,dos'

-- diagnostics
vim.diagnostic.config({severity_sort = true})

-- etc.
vim.opt.cursorline = true
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.clipboard = 'unnamed'
vim.opt.mouse = 'a'
vim.opt.iminsert = 0
vim.opt.imsearch = -1
vim.opt.incsearch = true
-- vim.opt.t_Co = 256
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.virtualedit:append('block')
vim.opt.matchpairs:append('<:>')
vim.opt.belloff = 'all'
vim.opt.showmode = false
vim.opt.conceallevel = 0
vim.opt.ambiwidth = 'single'
vim.opt.hidden = true
vim.opt.scrolloff = 1
vim.opt.updatetime = 150
vim.opt.equalalways = false
vim.opt.lazyredraw = true
vim.opt.signcolumn = 'yes'
vim.opt.helplang = {'ja', 'en'}
vim.opt.laststatus = 3
vim.opt.fillchars = {
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft  = '┫',
    vertright = '┣',
    verthoriz = '╋',
}
vim.opt.splitright = true
vim.opt.timeoutlen = 2000
vim.opt.shortmess:append('I')

-- disable default plugins
vim.g.loaded_netrw              = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_netrwSettings      = 1
vim.g.loaded_netrwFileHandlers  = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_tar                = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_zip                = 1
vim.g.loaded_zipPlugin          = 1
vim.g.loaded_rrhelper           = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_vimball            = 1
vim.g.loaded_vimballPlugin      = 1
vim.g.loaded_getscript          = 1
vim.g.loaded_getscriptPlugin    = 1
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.skip_loading_mswin        = 1

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    local clipboard = {}
    clipboard['name'] = 'win32yank'
    clipboard['copy'] = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    }
    clipboard['paste'] = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    }
    clipboard['cache_enabled'] = 0
    vim.g.clipboard = clipboard
end

vim.opt.pumblend = 30
vim.opt.winblend = 30

vim.filetype.add({
    extension = {
        toml = 'toml',
        md   = 'markdown',
        mdwn = 'markdown',
        mkd  = 'markdown',
        mkdn = 'markdown',
        mark = 'markdown',
    }
})

