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
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        -- stage/unstage
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map('n',        '<leader>gS', gs.stage_buffer)
        map('n',        '<leader>gu', gs.undo_stage_hunk)

        -- reset
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('n',        '<leader>gR', gs.reset_buffer)

        -- diff
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function() gs.diffthis('~') end)

        -- preview
        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gb', function() gs.blame_line{full=true} end)

        -- toggle
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>td', gs.toggle_deleted)
        map('n', '<leader>tw', gs.toggle_word_diff)
        map('n', '<leader>tl', gs.toggle_linehl)
        map('n', '<leader>tn', gs.toggle_numhl)
        map('n', '<leader>ts', gs.toggle_signs)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})
