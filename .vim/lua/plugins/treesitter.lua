if vim.g.vscode then
    return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSUpdateSync' },
    build = ':TSUpdate',
    dependencies = {
      'haringsrob/nvim_context_vt',
      'm-demare/hlargs.nvim',
      {
        'Wansmer/treesj',
        config = function()
          require('treesj').setup({
            use_default_keymaps = false,
          })
          vim.keymap.set('n', '<Leader>M', function()
            require('treesj').toggle({ split = { recursive = true } })
          end)
        end,
      },
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'RRethy/nvim-treesitter-textsubjects',
    },
    config = function()
      require('treesitter-setup').setup()
    end,
  },
}
