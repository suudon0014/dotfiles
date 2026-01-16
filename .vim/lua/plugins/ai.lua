if vim.g.vscode then
    return {}
end

return {
    {
        'folke/sidekick.nvim',
        event = { 'VeryLazy' },
        keys = {
            { "<C-.>", function() require("sidekick.cli").toggle({ name = "gemini", focus = true }) end, mode = { "n", "t", "i", "x" }, desc = "Sidekick Toggle" },
            {"<Leader>ka", function() require("sidekick.cli").toggle({ name = "gemini", focus = true }) end, desc = "Sidekick Toggle CLI" },
            {"<Leader>ks", function() require("sidekick.cli").select() end, desc = "Select CLI" },
            {"<Leader>kd", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session" },
            {"<Leader>kt", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This" },
            {"<Leader>kf", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
            {"<Leader>kv", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x", desc = "Send Visual Selection" },
            {"<Leader>kp", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },
        },
        opts = {
            nes = { enabled = false },
            cli = { tools = { gemini = { cmd = { "pnpm", "dlx", "@google/gemini-cli" }}}},
        },
    },
    {
        'Robitx/gp.nvim',
        cmd = {"GpAppend", "GpChatNew", "GpChatFinder", "GpRewrite", "GpPrepend", "GpImplement", "GpTranslateToJp", "GpTranslateToEn", "GpNew", "GpVnew", "GpExplainCode", "GpCreateCommitMessage", "GpRefactor", "GpChatPaste"},
        keys = {
            { "<C-g>c", ":<C-u>'<,'>GpAppend " .. require("utils").LoadTextFile("codeCompletion.md") .. "<CR>", mode = "v", desc = "LLM prompt Completion", nowait = true, silent = true, noremap = true },
            { "<C-g>n", "<Cmd>GpChatNew<CR>", mode = { "n", "i" }, desc = "LLM prompt New Chat", nowait = true, silent = true, noremap = true },
            { "<C-g>n", ":<C-u>'<,'>GpChatNew<CR>", mode = "v", desc = "LLM prompt New Chat", nowait = true, silent = true, noremap = true },
            { "<C-g>f", "<Cmd>GpChatFinder<CR>", mode = { "n", "i" }, desc = "LLM prompt Chat Finder", nowait = true, silent = true, noremap = true },
            { "<C-g>rw", "<Cmd>GpRewrite<CR>", mode = { "n", "i" }, desc = "LLM prompt Rewrite", nowait = true, silent = true, noremap = true },
            { "<C-g>rw", ":<C-u>'<,'>GpRewrite<CR>", mode = "v", desc = "LLM prompt Rewrite", nowait = true, silent = true, noremap = true },
            { "<C-g>a", "<Cmd>GpAppend<CR>", mode = { "n", "i" }, desc = "LLM prompt Append", nowait = true, silent = true, noremap = true },
            { "<C-g>a", ":<C-u>'<,'>GpAppend<CR>", mode = "v", desc = "LLM prompt Append", nowait = true, silent = true, noremap = true },
            { "<C-g>p", "<Cmd>GpPrepend<CR>", mode = { "n", "i" }, desc = "LLM prompt Prepend", nowait = true, silent = true, noremap = true },
            { "<C-g>p", ":<C-u>'<,'>GpPrepend<CR>", mode = "v", desc = "LLM prompt Prepend", nowait = true, silent = true, noremap = true },
            { "<C-g>i", ":<C-u>'<,'>GpImplement<CR>", mode = "v", desc = "LLM prompt Implement", nowait = true, silent = true, noremap = true },
            { "<C-g>tj", ":<C-u>'<,'>GpTranslateToJp<CR>", mode = "v", desc = "LLM prompt Translate to JP", nowait = true, silent = true, noremap = true },
            { "<C-g>te", ":<C-u>'<,'>GpTranslateToEn<CR>", mode = "v", desc = "LLM prompt Translate to EN", nowait = true, silent = true, noremap = true },
            { "<C-g>s", "<Cmd>GpNew<CR>", mode = { "n", "i" }, desc = "LLM prompt New with split", nowait = true, silent = true, noremap = true },
            { "<C-g>s", ":<C-u>'<,'>GpNew<CR>", mode = "v", desc = "LLM prompt New with split", nowait = true, silent = true, noremap = true },
            { "<C-g>v", "<Cmd>GpVnew<CR>", mode = { "n", "i" }, desc = "LLM prompt Vnew with vsplit", nowait = true, silent = true, noremap = true },
            { "<C-g>v", ":<C-u>'<,'>GpVnew<CR>", mode = "v", desc = "LLM prompt Vnew with vsplit", nowait = true, silent = true, noremap = true },
            { "<C-g>e", ":<C-u>'<,'>GpExplainCode<CR>", mode = "v", desc = "LLM prompt Explain Code", nowait = true, silent = true, noremap = true },
            { "<C-g>g", ":<C-u>'<,'>GpCreateCommitMessage<CR>", mode = "v", desc = "LLM prompt Commit Message", nowait = true, silent = true, noremap = true },
            { "<C-g>rf", ":<C-u>'<,'>GpRefactor<CR>", mode = "v", desc = "LLM prompt Refactor", nowait = true, silent = true, noremap = true },
            { "<C-g>y", ":<C-u>'<,'>GpChatPaste<CR>", mode = "v", desc = "LLM prompt Paste to Chat", nowait = true, silent = true, noremap = true },
        },
        config = function()
            local LoadTextFile = require('utils').LoadTextFile
            local general_system_prompt = LoadTextFile("generalSystemPrompt.md")

            local conf = {
                chat_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.expand('~'), 'OneDrive/gp/chats')),
                providers = {
                    googleai = {
                        endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
                        secret = os.getenv("GEMINI_API_KEY"),
                    },
                },
                agents = {
                    {
                        name = "Gemini-Pro",
                        provider = "googleai",
                        chat = true,
                        command = true,
                        model = { model = "gemini-2.5-pro", top_k = 40 },
                        system_prompt = general_system_prompt,
                    },
                    {
                        name = "Gemini-Flash",
                        provider = "googleai",
                        chat = true,
                        command = true,
                        model = { model = "gemini-2.5-flash", top_k = 40 },
                        system_prompt = general_system_prompt,
                    },
                },
                hooks = {
                    TranslateToJp = function(gp, params)
                        local prompt = LoadTextFile("translateJp.md")
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.new, agent, prompt)
                    end,

                    TranslateToEn = function(gp, params)
                        local prompt = LoadTextFile("translateEn.md")
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.new, agent, prompt)
                    end,

                    ExplainCode = function(gp, params)
                        local prompt = LoadTextFile("explainCode.md")
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.new, agent, prompt)
                    end,

                    CreateCommitMessage = function(gp, params)
                        local prompt = LoadTextFile("createCommitMessage.md")
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.new, agent, prompt)
                    end,

                    Refactor = function(gp, params)
                        local prompt = LoadTextFile("refactor.md")
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.append, agent, prompt)
                    end,
                },
            }
            require('gp').setup(conf)

            local gpNvimScriptFilePath = vim.fs.normalize(vim.fs.joinpath(vim.fn.expand('~'), 'dotfiles/.vim/llm_prompt/gp_nvim_func.vim'))
            vim.api.nvim_command("source " .. gpNvimScriptFilePath)
        end,
    },
    {
        'ravitemer/mcphub.nvim',
        build = 'pnpm install -g mcp-hub@latest',
        cmd = { "MCPHub" },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { "<Leader>m", ":MCPHub<CR>", desc = "Open McpHub", noremap = true, silent = true, nowait = true },
        },
        opts = {
            extensions = {
                avante = {
                    make_slash_commands = true,
                },
            }
        },
    },
    {
        'olimorris/codecompanion.nvim',
        dependencies = {
            'ravitemer/mcphub.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanionCmd' },
        keys = {
            { 'cci', 'CodeCompanion', mode = 'ca', desc = 'CodeCompanion' },
            { 'ccc', 'CodeCompanionChat', mode = 'ca', desc = 'CodeCompanionChat' },
            { 'cct', 'CodeCompanionChat Toggle', mode = 'ca', desc = 'CodeCompanionChat Toggle' },
            { 'cca', 'CodeCompanionActions', mode = 'ca', desc = 'CodeCompanionActions' },
            { 'ccx', 'CodeCompanionCmd', mode = 'ca', desc = 'CodeCompanionCmd' },
        },
        config = function()
            local LoadTextFile = require('utils').LoadTextFile

            local default_system_prompt = require('codecompanion.config').opts.system_prompt

            require('codecompanion').setup({
                adapters = {
                    gemini = function()
                        return require('codecompanion.adapters').extend('gemini', {
                            schema = {
                                model = {
                                    default = "gemini-2.5-flash",
                                    choices = {
                                        "gemini-2.5-flash",
                                        "gemini-2.5-pro",
                                    },
                                },
                            },
                        })end,
                },
                strategies = {
                    chat = {adapter = "gemini",},
                    inline = {adapter = "gemini",},
                    agent = {adapter = "gemini",},
                },
                opts = {
                    system_prompt = function (opts)
                        local my_system_prompt = LoadTextFile("generalSystemPrompt.md")
                        return default_system_prompt(opts) .. '\n\n' .. my_system_prompt
                    end,
                    language = "Japanese",
                },
                display = {
                    chat = {
                        auto_scroll = true,
                        show_header_separator = true,
                    },
                },
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            show_result_in_chat = false,
                            make_vars = true,
                            make_slash_commands = true,
                        },
                    },
                },
            })
        end,
    },
    {
        'yetone/avante.nvim',
        build = 'pwsh -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false',
        dependencies = {
            'ravitemer/mcphub.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        cmd = { 'AvanteAsk', 'AvanteChat', 'AvanteEdit', 'AvanteFocus', 'AvanteRefresh', 'AvanteShowRepoMap', 'AvanteToggle' },
        keys = {
            { '<Leader>aa', '<Cmd>AvanteAsk<CR>', desc = 'Avante Ask', noremap = true, silent = true },
            { '<Leader>af', '<Cmd>AvanteFocus<CR>', desc = 'Avante Focus', noremap = true, silent = true },
            { '<Leader>ar', '<Cmd>AvanteRefresh<CR>', desc = 'Avante Refresh', noremap = true, silent = true },
            { '<Leader>aR', '<Cmd>AvanteShowRepoMap<CR>', desc = 'Avante Show Repo Map', noremap = true, silent = true },
            { '<Leader>at', '<Cmd>AvanteToggle<CR>', desc = 'Avante Toggle', noremap = true, silent = true },
        },
        config = function()
            require('avante_lib').load()
            require('avante').setup({
                provider = "gemini",
                auto_suggestions_provider = "gemini",
                cursor_applying_provider = "gemini",
                behavior = {
                    auto_suggestions = false,
                    auto_set_highlight_group = true,
                    auto_set_keymaps = true,
                    auto_apply_diff_after_generation = true,
                    enable_cursor_planning_mode = true,
                },
                providers = {
                    gemini = {model = "gemini-2.5-flash"},
                    gemini_2_5_flash = {
                        __inherited_from = "gemini",
                        model = "gemini-2.5-flash",
                    },
                    gemini_2_5_pro = {
                        __inherited_from = "gemini",
                        model = "gemini-2.5-pro",
                    },
                },
                system_prompt = function ()
                    local hub = require("mcphub").get_hub_instance()
                    return hub:get_active_servers_prompt()
                end,
                custom_tools = function ()
                    return {
                        require("mcphub.extensions.avante").mcp_tool(),
                    }
                end,
            })
        end,
    },
    {
        'nvim-lua/plenary.nvim',
        lazy = true,
    },
    {
        'MunifTanjim/nui.nvim',
        lazy = true,
    },
}
