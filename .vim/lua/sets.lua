-- set backup folders
vim.opt.undodir = vim.env.HOME .. "/vimtmp/undo"
vim.opt.backupdir = vim.env.HOME .. "/vimtmp/bk"
vim.opt.directory = vim.env.HOME .. "/vimtmp/swap"
vim.opt.swapfile = false

-- about search
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
vim.opt.termencoding = 'utf-8'
vim.opt.fileformats = 'unix,dos'

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

-- disable default plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

if vim.fn.has('nvim') == 1 then
    vim.opt.pumblend = 30
    vim.opt.winblend = 30
end

local sets_au_group_id = vim.api.nvim_create_augroup('setsAuGroup', {})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'*.toml'},
    callback = function ()
        vim.opt.filetype = 'toml'
    end,
    group = sets_au_group_id,
})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'*.md', '*.mdwn', '*.mkd', '*.mkdn', '*.mark*'},
    callback = function ()
        vim.opt.filetype = 'markdown'
    end,
    group = sets_au_group_id,
})