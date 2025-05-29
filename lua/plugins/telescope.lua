return {
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{
				"<leader>ff",
				function() require("telescope.builtin").find_files() end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function() require("telescope.builtin").live_grep() end,
				desc = "Telescope Grep",
			},
			{
				"<leader>fb",
				function() require("telescope.builtin").buffers() end,
				desc = "Telescope buffers",
			},
			{
				"<leader>fh",
				function() require("telescope.builtin").help_tags() end,
				desc = "Telescope help tags",
			},
		}
	},
	{
		'RasmusKB/project.nvim',
		lazy = false,
		config = function()
			require('project_nvim').setup {
				detection_methods = {'pattern'},
				patterns = {'.git'},
				show_hidden = true,
			}
		require('telescope').load_extension('projects')
		end,
		keys = {
		  	{
				"<leader>fp",
				function() require("telescope").extensions.projects.projects{} end,
				desc = "Telescope projects",
			}
		}
	}
}

