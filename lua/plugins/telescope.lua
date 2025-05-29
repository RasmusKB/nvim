return {
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
		config = function()
			local fb_actions = require("telescope").extensions.file_browser
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<C-n>"] = "cycle_history_next",
							["<C-p>"] = "cycle_history_prev",
						},
						n = {
							["j"] = "move_selection_next",
							["k"] = "move_selection_previous",
						},
					},
					options = {
						sort_lastused = true,
						sort_mru = true,
					}
				},
				extensions = {
					file_browser = {
						mappings = {
							["i"] = {
								["<C-bs>"] = fb_actions.goto_parent_dir,
							},
							["n"] = {
								["<C-bs>"] = fb_actions.goto_parent_dir,
							}
						}
					}
				}
			}
			require('telescope').load_extension('file_browser')
		end,
		opts = {
			sort_lastused = true,
		},
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
			{
				"<leader>fv",
				function() require("telescope").extensions.file_browser.file_browser{
					path = vim.fn.expand("%:p:h"),
				}
				end,
				desc = "Telescope file browser"
			}
		}
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
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

