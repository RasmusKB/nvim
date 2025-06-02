return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"python",
					"javascript",
				},
				highlight = {
					enable = true,
				},
			}
		end,
	},
	{
		'HiPhish/rainbow-delimiters.nvim',
		event = 'VeryLazy',
		config = function()
			vim.cmd [[
				highlight RainbowDelimiterRed     guifg=#fb4934
				highlight RainbowDelimiterOrange  guifg=#fe8019
				highlight RainbowDelimiterYellow  guifg=#fabd2f
				highlight RainbowDelimiterGreen   guifg=#b8bb26
				highlight RainbowDelimiterAqua    guifg=#8ec07c
				highlight RainbowDelimiterBlue    guifg=#83a598
				highlight RainbowDelimiterPurple  guifg=#d3869b
			]]
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = require('rainbow-delimiters').strategy['global'],
				},
				query = {
					[''] = 'rainbow-delimiters',
				},
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterOrange',
					'RainbowDelimiterYellow',
					'RainbowDelimiterGreen',
					'RainbowDelimiterAqua',
					'RainbowDelimiterBlue',
					'RainbowDelimiterPurple',
				},
			}
		end,
	}
}
