local M = {}

local cache_path = vim.fn.expand("~/.cache")
if not vim.fn.isdirectory(cache_path) then
  vim.fn.mkdir(cache_path, "p")
end

M.dpp_plugin_list = {
  'Shougo/dpp.vim',
  'Shougo/dpp-ext-installer',
  'Shougo/dpp-ext-toml',
  'Shougo/dpp-ext-lazy',
  'Shougo/dpp-ext-local',
  'staticWagomU/dpp-ext-lua',
  'Shougo/dpp-protocol-git',
  'vim-denops/denops.vim',
}

-- Filtering function for excluding plugins already in runtimepath
local function filter_runtimepath(plugin_list)
  local filtered_list = {}
  local runtimepath_table = vim.opt.runtimepath:get()
  local runtimepath_string = table.concat(runtimepath_table, ',')
  for _, plugin in ipairs(plugin_list) do
    local plugin_name = vim.fn.fnamemodify(plugin, ':t')
    local pattern = '/' .. plugin_name .. '/'
    if not string.find(runtimepath_string, pattern, 1, true) then -- search with case-insensitive
      table.insert(filtered_list, plugin)
    end
  end
  return filtered_list
end

M.filtered_plugin_list = filter_runtimepath(M.dpp_plugin_list)

for _, plugin in ipairs(M.filtered_plugin_list) do
  local plugin_dir_name = vim.fn.fnamemodify(plugin, ':t')  -- plugin name only
  local plugin_dir = vim.fn.fnamemodify(plugin_dir_name, ':p')  -- plugin's full path


--   if not vim.fn.isdirectory(plugin_dir) then
--     plugin_dir = cache_path .. '/dpp/repos/github.com/' .. plugin
--     if not vim.fn.isdirectory(plugin_dir) then
--       local git_clone_command = '!git clone https://github.com/' .. plugin .. ' ' .. plugin_dir
--       vim.fn.system(git_clone_command)
--     end
--   end

--   local runtimepath_add = vim.fn.fnamemodify(plugin_dir, ':p'):gsub('[/\\]$', '')
--   vim.opt.runtimepath:prepend(runtimepath_add)
end


return M

