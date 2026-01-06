return {
  {
    'rbtnn/vim-ambiwidth',
    init = function()
      vim.g.ambiwidth_cica_enabled = false
    end,
  },
  {
    'cohama/lexima.vim',
    event = { 'InsertEnter' },
    config = function()
      local leximaAuGroup = vim.api.nvim_create_augroup('leximaAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'ddu-ff-filter',
        callback = function()
          vim.b.lexima_disabled = 1
        end,
        group = leximaAuGroup,
      })

      vim.fn['lexima#add_rule']({ char = ',', input = ',<Space>' })
      vim.fn['lexima#add_rule']({ at = [[, \%#]], char = '<Enter>', input = '<BS><Enter>' })

      vim.fn['lexima#add_rule']({ at = [[<\%#]], char = '>', input = '', input_after = '>' })
      vim.fn['lexima#add_rule']({ at = [[\%#>]], char = '>', leave = '>' })
      vim.fn['lexima#add_rule']({ at = [[<\%#>]], char = '<BS>', input = '<BS>', delete = 1 })

      vim.fn['lexima#add_rule']({ at = [[^\s*\%#$]], char = '-', input = '- ', filetype = 'markdown' })
      vim.fn['lexima#add_rule']({ at = [[^\s*\%#$]], char = '*', input = '* ', filetype = 'markdown' })
      vim.fn['lexima#add_rule']({ at = [[^- \%#$]], char = '-', input = '<BS>-', filetype = 'markdown' })
      vim.fn['lexima#add_rule']({ at = [[^- \%#$]], char = '>', input = '<BS>>', filetype = 'markdown' })
      vim.fn['lexima#add_rule']({ at = [[^\s*\* \%#$]], char = '*', input = '<BS>*', filetype = 'markdown' })
    end,
  },
  {
    'AndrewRadev/linediff.vim',
    event = { 'CursorMoved' },
    init = function()
      vim.g.linediff_first_buffer_command = 'leftabove new'
      vim.g.linediff_second_buffer_command = 'rightbelow vertical new'
    end,
  },
  {
    'lervag/vimtex',
    ft = { 'tex' },
    init = function()
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks = {},
        options = {
          '-pdfdvi',
          '-verbose',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        },
      }
    end,
    config = function()
      vim.keymap.set('n', '<Leader>tc', '<Plug>(vimtex-compile)', { remap = true })
    end,
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'EasyAlign' },
    },
  },
  {
    'osyo-manga/vim-precious',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    dependencies = { 'Shougo/context_filetype.vim' },
    config = function()
      vim.g.precious_enable_switch_CursorMoved = {
        ['*'] = 0,
        help = 1,
        toml = 1,
      }

      local preciousAuGroup = vim.api.nvim_create_augroup('preciousAuGroup', {})
      vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        pattern = { '*' },
        command = 'PreciousSwitch',
        group = preciousAuGroup,
      })
      vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        pattern = { '*' },
        command = 'PreciousReset',
        group = preciousAuGroup,
      })
    end,
  },
  {
    'haya14busa/vim-edgemotion',
    keys = {
      { '<C-j>', '<Plug>(edgemotion-j)', mode = { 'n', 'v' }, desc = 'edgemotion-j' },
      { '<C-k>', '<Plug>(edgemotion-k)', mode = { 'n', 'v' }, desc = 'edgemotion-k' },
    },
  },
  {
    'mechatroner/rainbow_csv',
    ft = { 'csv' },
  },
  {
    'kshenoy/vim-signature',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    dependencies = { 'haya14busa/vim-asterisk' },
    config = function()
      local opts = { noremap = true, silent = true }

      require('hlslens').setup()

      vim.keymap.set('n', 'n', function()
        vim.cmd.normal({
          args = { vim.v.count1 .. 'n' },
          bang = true,
          mods = { silent = true, emsg_silent = true },
        })
        require('hlslens').start()
      end, opts)

      vim.keymap.set('n', 'N', function()
        vim.cmd.normal({
          args = { vim.v.count1 .. 'N' },
          bang = true,
          mods = { silent = true, emsg_silent = true },
        })
        require('hlslens').start()
      end, opts)

      vim.keymap.set({ 'n', 'x' }, '*', "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>")
      vim.keymap.set({ 'n', 'x' }, '#', "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>")
      vim.keymap.set({ 'n', 'x' }, 'g*', "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>")
      vim.keymap.set({ 'n', 'x' }, 'g#', "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>")
      vim.keymap.set('n', '<Leader>c', vim.cmd.nohlsearch, opts)
      vim.keymap.set('n', '<esc><esc>', function()
        vim.cmd.nohlsearch()
        return '<Esc>'
      end, opts)
    end,
  },
  {
    'machakann/vim-sandwich',
    event = { 'CursorMoved' },
  },
  {
    'Yggdroot/indentLine',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.g.indentLine_setConceal = 0
      vim.g.indentLine_char = '¦'
    end,
  },
  {
    'bronson/vim-trailing-whitespace',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.g.extra_whitespace_ignored_filetypes = { '', 'ddu-filer', 'ddu-ff', 'mason', 'lspsagafinder' }
    end,
  },
  {
    'tpope/vim-commentary',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      local commentaryAuGroup = vim.api.nvim_create_augroup('commentaryAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'cpp' },
        callback = function()
          vim.b.commentary_format = '// %s'
        end,
        group = commentaryAuGroup,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'matlab' },
        callback = function()
          vim.b.commentary_format = '% %s'
        end,
        group = commentaryAuGroup,
      })
    end,
  },
  {
    'easymotion/vim-easymotion',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.g.EasyMotion_smartcase = 1
    end,
  },
  {
    'terryma/vim-multiple-cursors',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
  },
  {
    'uga-rosa/ccc.nvim',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      require('ccc').setup({
        highlighter = {
          auto_enable = true,
        },
      })
    end,
  },
  {
    'dstein64/vim-startuptime',
    cmd = { 'StartupTime' },
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'vim-jp/vimdoc-ja',
    ft = { 'help' },
  },
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
  },
  {
    'itchyny/vim-qfedit',
    ft = { 'qf' },
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      require('hlchunk').setup({})
    end,
  },
  {
    'mbbill/undotree',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
  },
  {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    keys = {
      { '<Leader>o', desc = 'Open parent directory' },
    },
    config = function()
      require('oil').setup({
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set('n', '<Leader>o', vim.cmd.Oil, { desc = 'Open parent directory' })
    end,
  },
  {
    'folke/which-key.nvim',
    event = { 'VeryLazy' },
    config = function()
      local wk = require('which-key')
      wk.add({
        { '<Leader>g', group = 'gitsigns', mode = { 'n', 'v' } },
        { '<Leader>gs', group = 'stage', mode = { 'n', 'v' } },
        { '<Leader>gr', group = 'reset', mode = { 'n', 'v' } },
        { '<Leader>gd', group = 'diff' },
        { '<Leader>gt', group = 'toggle' },

        { '<Leader>s', group = 'session' },

        { '<C-g>', group = 'gp.nvim', mode = { 'n', 'v' } },
        { '<C-g>t', group = 'translate (gp.nvim)', mode = { 'v' } },

        { ',a', group = 'ddu (arglist)' },
        { ',f', group = 'ddu (file)' },
        { ',g', group = 'ddu (git)' },
        { ',o', group = 'ddu (obsidian)' },
        { ',r', group = 'ddu (grep)' },

        { '<Leader>t', group = 'translate (google)', mode = { 'n', 'v' } },
        { '<C-l>', group = 'LSP', mode = { 'n', 'v' } },
      })
      vim.keymap.set('n', '<Leader>?', function()
        require('which-key').show({ global = false })
      end, { desc = 'Buffer Local Keymaps (which-key)' })
    end,
  },
  {
    'skanehira/vsession',
    cmd = { 'DeleteSession', 'LoadSession', 'SaveSession' },
    init = function()
      vim.keymap.set('n', '<Leader>s', '<Nop>', { remap = false })
      vim.keymap.set('n', '<Leader>sd', vim.cmd.DeleteSession, { desc = 'delete' })
      vim.keymap.set('n', '<Leader>sl', vim.cmd.LoadSession, { desc = 'load' })
      vim.keymap.set('n', '<Leader>ss', vim.cmd.SaveSession, { desc = 'save' })
    end,
    config = function()
      vim.g.vsession_save_last_on_leave = 0
      vim.g.vsession_ui = 'fzf'

      local vsessionAuGroup = vim.api.nvim_create_augroup('vsessionAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'vsession-quickpick' },
        callback = function()
          vim.keymap.set('n', 'q', vim.cmd.close, { remap = false, buffer = true, silent = true })
        end,
        group = vsessionAuGroup,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'vsession-quickpick-filter' },
        callback = function()
          vim.keymap.set('n', 'q', '<Plug>(vsession-quickpick-cancel)', { remap = true, buffer = true, silent = true })
        end,
        group = vsessionAuGroup,
      })
    end,
  },
  {
    'thinca/vim-quickrun',
    cmd = { 'QuickRun' },
    init = function()
      vim.keymap.set('n', ',q', vim.cmd.QuickRun, { remap = false, silent = true, desc = 'QuickRun' })
    end,
  },
}
