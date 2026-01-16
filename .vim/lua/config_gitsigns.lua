local M = {}

function M.setup()
    require('gitsigns').setup({
        signcolumn = true,
        numhl = false,
        linehl = false,

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
              vim.schedule(function() gs.nav_hunk('next') end)
              return '<Ignore>'
            end, {expr=true, desc='gitsigns.nav_hunk:next'})

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.nav_hunk('prev') end)
              return '<Ignore>'
            end, {expr=true, desc='gitsigns.nav_hunk:prev'})

            -- Text object
            map({'o', 'x'}, 'ih', gs.select_hunk)
        end
    })
end

return M