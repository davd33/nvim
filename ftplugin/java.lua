-- Java
local jdtls = require('jdtls')

-- 1. Setup paths dynamically via Mason
local mason_registry = require('mason-registry')
local jdtls_pkg = mason_registry.get_package('jdtls')
local jdtls_path = jdtls_pkg:get_install_path()

local lombok_path = jdtls_path .. '/lombok.jar'

-- 2. Define workspace folder for cache metadata
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java-workspace-root/' .. project_name

-- Ensure root_dir resolves to a valid path string
local root_dir = jdtls.setup.find_root({'.git', 'gradlew', 'build.gradle', 'pom.xml'})
if root_dir == "" or not root_dir then
  root_dir = vim.fn.getcwd()
end

-- 3. Define the config table
local config = {
  cmd = {
    -- Java 21 executable (required to run JDTLS)
    '/home/davd33/.sdkman/candidates/java/21.0.8-tem/bin/java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-Xmx1G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- Attach Mason's Lombok agent
    '-javaagent:' .. lombok_path,

    -- Launcher JAR & Config path
    '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', jdtls_path .. '/config_linux', -- Change to 'config_mac' or 'config_win' if on macOS/Windows

    '-data', workspace_dir
  },

  root_dir = root_dir,

  settings = {
    java = {
      import = {
        gradle = {
          enabled = true,
          java = {
            home = "/home/davd33/.sdkman/candidates/java/11.0.31-amzn/" -- Forces Gradle tooling to Java 11
          }
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
}

-- 4. Pass the config variable into jdtls to start the LSP engine
jdtls.start_or_attach(config)
