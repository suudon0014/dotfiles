local M = {}

-- Pathコマンド用関数
function M.show_path()
    print(vim.fn.expand('%:p'))
end

-- Profileコマンド用関数
function M.start_profile()
    vim.cmd.profile('start ~/profile.txt')
    vim.cmd.profile('func *')
    vim.cmd.profile('file *')
end

return M