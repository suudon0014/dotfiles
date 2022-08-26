require('gitsigns').setup({
    signcolumn = true,
    numhl = true,
    linehl = true,

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='gitsigns.next_hunk'})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='gitsigns.next_hunk'})

        -- Actions
        -- stage/unstage
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map('n',        '<leader>gS', gs.stage_buffer, {desc='gitsigns.stage_buffer'})
        map('n',        '<leader>gu', gs.undo_stage_hunk, {desc='gitsigns.undo_stage_hunk'})

        -- reset
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('n',        '<leader>gR', gs.reset_buffer, {desc='gitsigns.reset_buffer'})

        -- diff
        map('n', '<leader>gd', gs.diffthis, {desc='gitsigns.diffthis'})
        map('n', '<leader>gD', function() gs.diffthis('~') end, {desc='gitsigns.diffthis("~")'})

        -- preview
        map('n', '<leader>gp', gs.preview_hunk, {desc='gitsigns.preview_hunk'})
        map('n', '<leader>gb', function() gs.blame_line{full=true} end, {desc='gitsigns.blame_line{full=true}'})

        -- toggle
        map('n', '<leader>tb', gs.toggle_current_line_blame, {desc='gitsigns.toggle_current_line_blame'})
        map('n', '<leader>td', gs.toggle_deleted, {desc='gitsigns.toggle_deleted'})
        map('n', '<leader>tw', gs.toggle_word_diff, {desc='gitsigns.toggle_word_diff'})
        map('n', '<leader>tl', gs.toggle_linehl, {desc='gitsigns.toggle_linehl'})
        map('n', '<leader>tn', gs.toggle_numhl, {desc='gitsigns.toggle_numhl'})
        map('n', '<leader>ts', gs.toggle_signs, {desc='gitsigns.toggle_signs'})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})
