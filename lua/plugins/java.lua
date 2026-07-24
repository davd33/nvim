return {
    'nvim-java/nvim-java',
    ft = 'java',
    dependencies = {
        { 'JavaHello/spring-boot.nvim' },
    },
    config = function ()
        require('java').setup()

        vim.lsp.config('jdtls', {
            settings = {
                java = {
                    format = {
                        enabled = true,
                        settings = {
                            url = vim.fn.stdpath("config") .. "jdtls-config/eclipse-java-google-style.xml",
                            profile = "GoogleStyle"
                        }
                    },
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-11",
                                path = "/home/davd33/.sdkman/candidates/java/11.0.31-amzn/",
                                default = true,
                            },
                            {
                                name = "JavaSE-21",
                                path = "/home/davd33/.sdkman/candidates/java/21.0.8-tem/",
                            },
                        }
                    }
                }
            }
        })

        vim.lsp.enable('jdtls')
    end
}
