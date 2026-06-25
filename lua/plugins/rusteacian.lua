return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false, -- this plugin is already lazy
    config = function ()
        local mason_registry = require('mason-registry')
        local codelldb = mason_registry.get_package('codelldb')
        local extension_path = codelldb:get_install_path() .. '/extension/'
        local codelldb_path = extension_path .. 'adapter/codelldb.exe'
        local liblldb_path = extension_path .. 'lldb/bin/liblldb.dll'
        local cfg = require('rustaceanvim.config')

        vim.api.nvim_create_user_command("RustDebugArgs", function()
            vim.ui.input({
                prompt = "Program args: ",
            }, function(input)
                    if not input then
                        return
                    end

                    local cmd = "RustLsp debuggables"
                    if input ~= "" then
                        cmd = cmd .. " " .. input
                    end

                    vim.cmd(cmd)
                end)
        end, {})

        vim.g.rustaceanvim = {
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
        }
    end
}
