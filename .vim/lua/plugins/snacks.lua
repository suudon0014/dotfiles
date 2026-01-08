return {
    {
      "folke/snacks.nvim",
      event = {'VeryLazy'},
      opts = {
        bigfile = { enabled = true },
        explorer = { enabled = true, hidden = true, ignore = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = {
            enabled = true,
            hidden = true,
            sources = {
                projects = {
                    projects = { "~/OneDrive/obsidian", },
                },
            },
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      },
      keys = {
          {',sa', function() Snacks.picker.grep({ hidden = true }) end, desc = 'Grep'},
          {',sb', function() Snacks.picker.buffers() end, desc = 'Buffers'},
          {',sc', function() Snacks.picker.command_history() end, desc = 'Command History'},
          {',sC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes'},
          {',se', function() Snacks.explorer() end, desc = 'Explorer'},
          {',sf', function() Snacks.picker.files({ hidden = true }) end, desc = 'Files'},
          {',sgd', function() Snacks.picker.git_diff() end, desc = 'Git Diff'},
          {',sgs', function() Snacks.picker.git_status() end, desc = 'Git Status'},
          {',sh', function() Snacks.picker.help() end, desc = 'Help'},
          {',sl', function() Snacks.picker.lines() end, desc = 'Lines'},
          {',sma', function() Snacks.picker.marks() end, desc = 'Marks'},
          {',sp', function() Snacks.picker.projects() end, desc = 'Projects'},
          {',sr', function() Snacks.picker.recent() end, desc = 'Recent files'},
      },
      init = function()
          vim.api.nvim_create_autocmd("FileType", {
              pattern = "snacks_picker_list",
              callback = function (ev)
                  vim.api.nvim_set_hl(ev.buf, 'SnacksPickerListCursorLine', { bg = '#FF6077', underline = true })
              end
          })
      end,
  },
}
