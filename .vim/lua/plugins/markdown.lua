return {
  {
    'sano-jin/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
    end,
    config = function()
      vim.keymap.set('n', '<C-p>', '<Plug>MarkdownPreview', { remap = true })
    end,
  },
}
