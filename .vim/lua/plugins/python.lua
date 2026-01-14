if vim.g.vscode then
    return {}
end

return {
  {
    'jmcantrell/vim-virtualenv',
    ft = { 'python' },
    init = function()
      vim.g.virtualenv_directory = '.'
    end,
  },
  {
    'jupyter-vim/jupyter-vim',
    ft = { 'python' },
    config = function()
      local jupyterAuGroup = vim.api.nvim_create_augroup('jupyterAuGroup', {})
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'python' },
        callback = function()
          local opts = { remap = false, buffer = true, silent = true }
          vim.keymap.set('n', '<Leader>jc', vim.cmd.JupyterConnect, opts)
          vim.keymap.set('n', '<Leader>jd', vim.cmd.JupyterDisconnect, opts)
          vim.keymap.set('n', '<Leader>js', vim.cmd.JupyterSendCell, opts)
          vim.keymap.set({ 'n', 'v' }, '<Leader>jr', vim.cmd.JupyterSendRange, opts)
        end,
        group = jupyterAuGroup,
      })
    end,
  },
  {
    'goerz/jupytext.vim',
    event = { 'BufReadPre *.ipynb', 'BufNewFile *.ipynb', 'BufReadPre *.py', 'BufNewFile *.py' },
    init = function()
      vim.g.jupytext_fmt = 'py:percent'
      vim.g.jupytext_filetype_map = { py = 'python' }
    end,
  },
}
