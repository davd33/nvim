return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false, -- this plugin is already lazy
    config = function ()
        local mason_registry = require('mason-registry')
        local codelldb = mason_registry.get_package('codelldb')
        local extension_path = codelldb:get_install_path() .. '/extension/'
        local system = vim.uv.os_uname().sysname

        local codelldb_path
        local liblldb_path

        if system == "Windows_NT" then
            codelldb_path = extension_path .. "adapter/codelldb.exe"
            liblldb_path = extension_path .. "lldb/bin/liblldb.dll"
        elseif system == "Linux" then
            codelldb_path = extension_path .. "adapter/codelldb"
            liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        elseif system == "Darwin" then
            codelldb_path = extension_path .. "adapter/codelldb"
            liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        end

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
