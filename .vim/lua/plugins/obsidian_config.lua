if vim.g.vscode then
    return {}
end

local obsidian_vault_dir = (vim.fn.expand("~") .. "/OneDrive/obsidian"):gsub("\\", "/")

return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    cmd = { 'Obsidian' },
    dependencies = { 'saghen/blink.cmp' },
    opts = {
      legacy_commands = false,
      note_id_func = function(title)
        return os.date('%Y%m%d%H%M%S')
      end,
      workspaces = {
        {
          name = 'my_vault',
          path = obsidian_vault_dir,
        },
      },
      daily_notes = {
        folder = '02_Daily',
        date_format = '%Y%m%d000000',
      },
      preferred_link_style = 'markdown',
      frontmatter = {
        enabled = true,
        sort = { 'uid', 'title', 'aliases', 'tags', 'note_type', 'created', 'updated' },
        func = function(note)
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            out = vim.tbl_extend('force', out, note.metadata)
          end

          if out.uid == nil then
            out.uid = os.date('%Y%m%d%H%M%S')
          end

          if out.title == nil then
            out.title = note.id
          end

          if out.aliases == nil or #out.aliases == 0 then
            out.aliases = { out.title }
          end

          if out.note_type == nil then
            out.note_type = ''
          end

          if out.created == nil then
            out.created = os.date('%Y-%m-%d %H:%M')
          end

          out.updated = os.date('%Y-%m-%d %H:%M')

          return out
        end,
      },
      callbacks = {
        pre_write_note = function(note)
          note:add_field('updated', os.date('%Y-%m-%d %H:%M'))
        end,
      },
    },
    init = function ()
        local obsidian_group = vim.api.nvim_create_augroup("ObsidianConceal", { clear = true })
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = obsidian_vault_dir .. "/**/*.md",
            group = obsidian_group,
            callback = function()
                vim.opt_local.conceallevel = 2
            end,
        })
    end,
  },
}
