if vim.g.vscode then
  return {}
end

local not_vscode = not vim.g.vscode

return {
  {
    'cohama/lexima.vim',
    cond = not_vscode,
    event = { 'InsertEnter' },
    config = function()
      local leximaAuGroup = vim.api.nvim_create_augroup('leximaAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'snacks_picker_input',
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
    cond = not_vscode,
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
    cond = not_vscode,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
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
    'machakann/vim-sandwich',
    event = { 'CursorMoved' },
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
    event = { 'VeryLazy' },
    config = function()
      vim.g.EasyMotion_smartcase = 1
    end,
  },
  {
    'terryma/vim-multiple-cursors',
    event = { 'VeryLazy' },
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
    'simrat39/rust-tools.nvim',
    cond = not_vscode,
    ft = { 'rust' },
  },
  {
    'itchyny/vim-qfedit',
    ft = { 'qf' },
  },
  {
    'mbbill/undotree',
    event = { 'InsertEnter', 'BufReadPost', 'BufNewFile' },
  },
  {
    'thinca/vim-quickrun',
    cmd = { 'QuickRun' },
    init = function()
      vim.keymap.set('n', ',q', vim.cmd.QuickRun, { remap = false, silent = true, desc = 'QuickRun' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    cond = not_vscode,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('config_gitsigns').setup()
      vim.keymap.set('n', '<Leader>gsb', require('gitsigns').stage_buffer, { desc = 'buffer' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>gsh', require('gitsigns').stage_hunk, { desc = 'hunk(toggle)' })
      vim.keymap.set('n', '<Leader>grb', require('gitsigns').reset_buffer, { desc = 'buffer' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>grh', require('gitsigns').reset_hunk, { desc = 'hunk' })
      vim.keymap.set('n', '<Leader>gdc', function()
        require('gitsigns').diffthis('~1')
      end, { desc = 'last commit' })
      vim.keymap.set('n', '<Leader>gdi', require('gitsigns').diffthis, { desc = 'index' })
      vim.keymap.set('n', '<Leader>gtb', require('gitsigns').toggle_current_line_blame, { desc = 'blame (line)' })
      vim.keymap.set('n', '<Leader>gtl', require('gitsigns').toggle_linehl, { desc = 'line highlight' })
      vim.keymap.set('n', '<Leader>gtn', require('gitsigns').toggle_numhl, { desc = 'num highlight' })
      vim.keymap.set('n', '<Leader>gts', require('gitsigns').toggle_signs, { desc = 'signs' })
      vim.keymap.set('n', '<Leader>gtw', require('gitsigns').toggle_word_diff, { desc = 'word diff' })
      vim.keymap.set('n', '<Leader>gb', function()
        require('gitsigns').blame_line({ full = true })
      end, { desc = 'blame(full)' })
      vim.keymap.set('n', '<Leader>gp', require('gitsigns').preview_hunk, { desc = 'preview' })
    end,
  },
}
