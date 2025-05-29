return {
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"voldikss/vim-floaterm",
		keys = {
			{
				"<leader>ft",
				"<cmd>FloatermToggle<CR>",
				desc = "Toggle Floaterm",
				mode = { "n", "t" },
			},
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = { "dashboard" }
			},
		},
	},
	{
		'akinsho/bufferline.nvim', version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
}
