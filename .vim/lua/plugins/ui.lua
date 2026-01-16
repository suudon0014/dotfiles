if vim.g.vscode then
  return {}
end

local not_vscode = not vim.g.vscode

return {
  {
    'rbtnn/vim-ambiwidth',
    cond = not_vscode,
    event = 'VeryLazy',
    init = function()
      vim.g.ambiwidth_cica_enabled = false
    end,
  },
  {
    'mechatroner/rainbow_csv',
    cond = not_vscode,
    ft = { 'csv' },
  },
  {
    'kshenoy/vim-signature',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
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
    'Yggdroot/indentLine',
    cond = not_vscode,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      vim.g.indentLine_setConceal = 0
      vim.g.indentLine_char = '¦'
    end,
  },
  {
    'bronson/vim-trailing-whitespace',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      vim.g.extra_whitespace_ignored_filetypes = { '', 'mason', 'lspsagafinder' }
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    cond = not_vscode,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('hlchunk').setup({})
    end,
  },
  {
    'stevearc/oil.nvim',
    cond = not_vscode,
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
    cond = not_vscode,
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

        { '<Leader>t', group = 'translate (google)', mode = { 'n', 'v' } },
        { '<C-l>', group = 'LSP', mode = { 'n', 'v' } },
      })
      vim.keymap.set('n', '<Leader>?', function()
        require('which-key').show({ global = false })
      end, { desc = 'Buffer Local Keymaps (which-key)' })
    end,
  },
}
