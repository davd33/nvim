return {
    {
        'mfussenegger/nvim-dap',
        config = function ()
            local dap, dapui = require('dap'), require('dapui')

            local rust_debugger = vim.fn.exepath(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe")
            if rust_debugger ~= "" then
                dap.adapters.codelldb = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = vim.fn.stdpath("data")
                            .. "/mason/packages/codelldb/extension/adapter/codelldb.exe",
                        args = { "--port", "${port}" },
                    },
                }
            end

            dap.configurations.rust = {
                {
                    name = "Cargo Run",
                    type = "codelldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = function ()
                        return vim.fn.input(
                            "Executable: ",
                            vim.fn.getcwd() .. "/target/debug/",
                            "file"
                        )
                        --return vim.fn.getcwd() .. 'target/debug' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    end,
                    args = function()
                        local args = vim.fn.input("Arguments: ")
                        return vim.split(args, " ", { trimempty = true })
                    end,
                },
            }

            dap.listeners.before.attach.dapui_config = function ()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function ()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function ()
                dapui.open()
            end
            dap.listeners.before.event_exited.dapui_config = function ()
                dapui.open()
            end
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'},
        config = function ()
            require("dapui").setup()
        end
    }
}
