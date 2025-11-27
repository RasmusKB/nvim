return {
	"nvim-pack/nvim-spectre",
	keys = {
		{'<leader>sr', "<cmd>Spectre<cr>",mode={'n'}},
	},
	config = function()
		require('spectre').setup({ is_block_ui_break = true })
	end,
}

