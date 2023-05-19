JAVA_DAP_ACTIVE = true
vim.fn.setenv("AWS_PROFILE", "bank-qa")
vim.fn.setenv("AWS_REGION", "us-east-1")
vim.fn.setenv("SPRING_PROFILES_ACTIVE", "qa")

local handlers = require("vm.lsp")
local status, jdtls = pcall(require, "jdtls")
if not status then
    return
end

local map = require("vm.functions").map
local home = os.getenv("HOME")
if vim.fn.has("unix") == 1 then
    WORKSPACE_PATH = home .. "/jdtls-workspace/"
    CONFIG = "config_linux"
else
    print("Unsupported system")
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local mason_packages_path = home .. '/.local/share/nvim/mason/packages'
local jdtls_path = mason_packages_path .. "/jdtls"
local lsp_server_path = jdtls_path .. "/" .. CONFIG
local plugins_path = jdtls_path .. "/plugins"
local jar_path = plugins_path .. "/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local lombok_path = jdtls_path .. "/lombok.jar"
local bundles = {}

--[[
for running tests:
    - https://github.com/microsoft/vscode-java-test
    - npm intall
    - node scripts/buildJdtlsExt.js
for debug:
    - https://github.com/eclipse/eclipse.jdt.ls
    - ./mvnw clean verify
    ]]
if JAVA_DAP_ACTIVE then
    vim.list_extend(bundles, vim.split(vim.fn.glob(mason_packages_path .. "/java-test/extension/server/*.jar"), "\n"))
    vim.list_extend(
        bundles,
        vim.split(
            vim.fn.glob(
                mason_packages_path .. '/java-debug-adapter/extension/server/*.jar'
            ),
            "\n"
        )
    )
    map("n", "<leader>tc", "<cmd> lua require'jdtls'.test_class()<cr>", '[T]ests [C]lass')
    map("n", "<leader>tnm", "<cmd> lua require'jdtls'.test_nearest_method()<cr>", '[T]est [N]earest [M]ethod')
end


local config = {
    filetypes = { "java" },
    cmd = {

        -- 💀
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. lombok_path,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jar_path,
        "-configuration",
        lsp_server_path,
        "-data",
        workspace_dir,
    },

    on_attach = handlers.custom_attach,
    capabilities = handlers.default_capabilities,
    root_dir = root_dir,
    settings = {
        java = {
            home = home .. "/.sdkman/candidates/java/current",
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = home .. "/.sdkman/candidates/java/17.0.5-oracle/",
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.sdkman/candidates/java/11.0.12-open/",
                    },
                },
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            -- format = {
            --     enabled = true,
            --     settings = {
            --         profile = "GoogleStyle",
            --         url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
            --     },
            -- },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
            },
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    },
}


vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")

jdtls.start_or_attach(config)
