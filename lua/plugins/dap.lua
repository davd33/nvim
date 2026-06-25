return {
    {
        'mfussenegger/nvim-dap',
        config = function ()
            local dap, dapui = require('dap'), require('dapui')

            local python = "python3"

            dap.adapters.python = {
                type = "executable",
                command = python,
                args = {
                    "-m",
                    "debugpy.adapter",
                },
            }

            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch current file",

                    program = "${file}",
                    cwd = "${workspaceFolder}",

                    console = "integratedTerminal",
                    justMyCode = true,
                },
                {
                    type = "python",
                    request = "launch",
                    name = "Launch with arguments",

                    program = function()
                        return vim.fn.input(
                            "Script: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",

                    args = function()
                        local args = vim.fn.input("Arguments: ")
                        return vim.split(args, " ", { trimempty = true })
                    end,

                    console = "integratedTerminal",
                    justMyCode = true,
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
            dap.listeners.before.launch.rust_terminal = function(_, config)
                config.console = "integratedTerminal"
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
