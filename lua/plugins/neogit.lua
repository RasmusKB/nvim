return {
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
		keys = {
			{"<leader>gh", function() require("neogit").open() end, desc = "open neogit"}
		}
	},
}
