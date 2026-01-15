if vim.g.vscode then
    return {}
end

return {
  {
    'mason-org/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'glepnir/lspsaga.nvim',
      'j-hui/fidget.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.cmd.source(vim.fn.expand('~/dotfiles/.vim/lua/nvim-lsp.lua'))
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    event = {'BufReadPost', 'BufNewFile', 'VeryLazy'},
    config = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'lspinfo' },
        callback = function()
          vim.keymap.set('n', 'q', vim.cmd.close, { remap = false, buffer = true, silent = true })
        end,
      })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    lazy = true,
  },
  {
    'j-hui/fidget.nvim',
    lazy = true,
  },
}
