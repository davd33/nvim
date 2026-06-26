return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {
                    enabled = true,
                    enabled_commands = true,

                    -- Show values next to variable definitions
                    virt_text_pos = "eol",

                    -- Highlight changed values
                    highlight_changed_variables = true,
                    highlight_new_as_changed = false,

                    -- Show stop reason
                    show_stop_reason = true,

                    -- Only show values for variables on the current line
                    all_frames = false,

                    -- Filter which variables get displayed
                    display_callback = function(variable)
                        if #variable.value > 80 then
                            return variable.value:sub(1, 77) .. "..."
                        end
                        return variable.value
                    end,
                },
            },
        },
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
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function ()
                dapui.close()
            end

            vim.keymap.set('n', '<space>=', function () 
                dapui.eval(nil, {enter=true})
            end)

            -- external terminal
            dap.defaults.fallback.external_terminal = {
                command = 'alacritty';
                args = {'-e'};
            }
            dap.defaults.fallback.force_external_terminal = true
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
