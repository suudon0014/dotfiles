if vim.g.vscode then
  return {}
end

return {
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
}