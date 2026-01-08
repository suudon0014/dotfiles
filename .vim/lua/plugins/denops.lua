return {
  {
    'vim-denops/denops.vim',
    event = 'VeryLazy',
    config = function()
      vim.g.denops_server_addr = '127.0.0.1:32123'
      vim.g['denops#debug'] = 0
    end,
  },
  {
      'yuki-yano/denops-lazy.nvim',
      event = 'VeryLazy',
  },
  {
    'skanehira/denops-translate.vim',
    dependencies = { 'vim-denops/denops.vim' },
    cmd = {'Translate'},
    keys = {
      { '<Leader>tr', '<Plug>(Translate)', mode = { 'n', 'v' }, remap = true },
    },
    config = function()
        require('denops-lazy').load('denops-translate.vim')
    end,
  },
  {
    'gamoutatsumi/dps-ghosttext.vim',
    dependencies = { 'vim-denops/denops.vim' },
    cmd = { 'GhostStart' },
    config = function()
      local tmp_table = {}
      tmp_table['gemini.google.com'] = 'markdown'
      tmp_table['aistudio.google.com'] = 'markdown'
      vim.g['dps_ghosttext#ftmap'] = vim.tbl_deep_extend('keep', vim.g['dps_ghosttext#ftmap'] or {}, tmp_table)

      require('denops-lazy').load('dps-ghosttext.vim')
    end,
  },
  {
    'lambdalisue/vim-gin',
    dependencies = { 'vim-denops/denops.vim' },
    cmd = { 'Gin', 'GinBuffer', 'GinBranch', 'GinChaperon', 'GinDiff', 'GinEdit', 'GinPatch', 'GinStatus', 'ShowGitDashboard' },
    config = function()
      vim.g.gin_log_default_args = { '--graph', '--oneline', '--all', '--date=short', '--decorate=short' }

      local function show_git_dashboard()
        vim.cmd.tabnew()
        vim.cmd.GinStatus('++opener=topleft split')
        vim.cmd.wincmd('j')
        vim.cmd.GinBranch()
        vim.cmd.GinLog('++opener=botright vsplit')
      end
      vim.api.nvim_create_user_command('ShowGitDashboard', show_git_dashboard, {})

      local ginAuGroup = vim.api.nvim_create_augroup('ginAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'gin-branch', 'gin-diff', 'gin-log', 'gin-status' },
        callback = function()
          vim.keymap.set('n', 'r', function()
            vim.cmd.edit({ bang = true })
          end, { remap = false, buffer = true, silent = true, desc = 'edit' })
          vim.keymap.set('n', 'q', function()
            vim.cmd.quit()
          end, { remap = false, buffer = true, silent = true, desc = 'quit' })
        end,
        group = ginAuGroup,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'gin-log' },
        callback = function()
          vim.keymap.set('n', 'gsh', '<Plug>(gin-action-show)', { remap = false, buffer = true, desc = 'gin-action-show' })
          vim.keymap.set('n', 'gsw', '<Plug>(gin-action-switch)', { remap = false, buffer = true, desc = 'gin-action-switch' })
        end,
        group = ginAuGroup,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'gin-status' },
        callback = function()
          vim.keymap.set('n', 'e', '<Plug>(gin-action-edit)', { remap = false, buffer = true, desc = 'gin-action-edit' })
        end,
        group = ginAuGroup,
      })

      require('denops-lazy').load('vim-gin')
    end,
  },
  {
    'vim-skk/skkeleton',
    dependencies = { 'vim-denops/denops.vim' },
    keys = {
      { '<C-j>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c', 't' }, remap = true },
    },
    event = {'InsertEnter'},
    config = function()
      vim.fn['skkeleton#config']({
        eggLikeNewline = true,
        globalDictionaries = { { '~/.config/skk/SKK-JISYO.L', 'euc-jp' } },
        userDictionary = '~/.config/skk/my_jisyo',
        completionRankFile = '~/.config/skk/rank.json',
        keepState = true,
        markerHenkan = '>',
        markerHenkanSelect = 'v',
      })
      vim.fn['skkeleton#register_kanatable']('rom', {
        jj = 'escape',
        c1 = { '\u{2460}' },
        c2 = { '\u{2461}' },
        c3 = { '\u{2462}' },
        c4 = { '\u{2463}' },
        c5 = { '\u{2464}' },
        c6 = { '\u{2465}' },
        c7 = { '\u{2466}' },
        c8 = { '\u{2467}' },
        c9 = { '\u{2468}' },
        c0 = { '\u{2469}' },
      })
      require('denops-lazy').load('skkeleton')
    end,
  },
  {
    'lambdalisue/kensaku.vim',
    lazy = true,
    dependencies = { 'vim-denops/denops.vim' },
    config = function()
      require('denops-lazy').load('kensaku.vim')
    end,
  },
  {
    'lambdalisue/kensaku-search.vim',
    dependencies = { 'lambdalisue/kensaku.vim' },
    event = 'CmdlineEnter',
    config = function()
      require('denops-lazy').load('kensaku-search.vim')
    end,
  },
}
