return {
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "pyright" },
			}
		end,
	}
}
