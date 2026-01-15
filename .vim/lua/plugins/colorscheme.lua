if vim.g.vscode then
    return {}
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'sainnhe/sonokai',
    },
    event = { 'VeryLazy' },
    config = function()
      require('lualine').setup()
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'sainnhe/sonokai',
    lazy = true,
    config = function()
      local colorSchemeAuGroup = vim.api.nvim_create_augroup('colorSchemeAuGroup', {})
      vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
        pattern = '*',
        callback = function()
          vim.api.nvim_set_hl(0, 'Folded', { bold = true, ctermfg = 10, fg = 'LightGreen' })
          vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = 8, bg = '#5d6173' })
          vim.api.nvim_set_hl(0, 'Comment', { cterm = {}, italic = false })
        end,
        group = colorSchemeAuGroup,
      })
      vim.cmd.colorscheme('sonokai')
    end,
  },
  {
    'folke/styler.nvim',
    lazy = true,
    dependencies = { 'sainnhe/sonokai' },
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    dependencies = { 'sainnhe/sonokai' },
  },
}
