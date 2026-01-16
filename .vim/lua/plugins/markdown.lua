if vim.g.vscode then
    return {}
end

return {
  {
    'sano-jin/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
    end,
    keys = {
      { '<C-p>', '<Plug>MarkdownPreview', desc = 'Markdown Preview', remap = true },
    },
  },
}
