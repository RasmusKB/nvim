return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            vim.lsp.enable('lua_ls')
        end,
    },
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local jdtls = require("jdtls")

					local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
					local config_dir = jdtls_dir .. "/config_linux"
					local plugins_dir = jdtls_dir .. "/plugins"
					local lombok_path = jdtls_dir .. "/lombok.jar"
					local path_to_jar = vim.fn.glob(plugins_dir .. "/org.eclipse.equinox.launcher_*.jar")

					local root_markers = { "build.gradle", "settings.gradle", ".git", "pom.xml" }
					local root_dir = require("jdtls.setup").find_root(root_markers)
					if not root_dir then return end

					local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
					local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
					vim.fn.mkdir(workspace_dir, "p")

					local config = {
						cmd = {
							"java",
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dlog.protocol=true",
							"-Dlog.level=ALL",
							"-javaagent:" .. lombok_path,
							"-Xms1g",
							"--add-modules=ALL-SYSTEM",
							"--add-opens", "java.base/java.util=ALL-UNNAMED",
							"--add-opens", "java.base/java.lang=ALL-UNNAMED",
							"-jar", path_to_jar,
							"-configuration", config_dir,
							"-data", workspace_dir,
						},
						root_dir = root_dir,
						settings = {
							java = {
								eclipse = { downloadSources = true },
								configuration = {
									updateBuildConfiguration = "interactive",
									runtimes = {
										{
											name = "JavaSE-21",
											path = "/usr/lib/jvm/java-1.21.0-openjdk-amd64",
										},
									},
								},
								maven = { downloadSources = true },
								implementationsCodeLens = { enabled = true },
								referencesCodeLens = { enabled = true },
								references = { includeDecompiledSources = true },
								format = {
									enabled = true,
									settings = {
										url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
										profile = "GoogleStyle",
									},
								},
							},
						},
						init_options = {
							bundles = {},
						},
						flags = {
							allow_incremental_sync = true,
						},
					}

					jdtls.start_or_attach(config)
				end,
			})
		end,
	}
}
