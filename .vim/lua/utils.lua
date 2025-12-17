local M = {}

function M.LoadTextFile(fileName)
    local home_dir = vim.fn.expand('~')
    local prompt_dir = 'dotfiles/.vim/llm_prompt'
    local filePath = home_dir .. '/' .. prompt_dir .. '/' .. fileName
    local file = io.open(filePath, "r")
    local prompt = ""
    if file then
        prompt = file:read("*a")
        file:close()
    end
    return prompt
end

return M
