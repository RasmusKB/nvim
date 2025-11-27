return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>bR", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
        { "<leader>bL", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
        options = {
            close_command = function(bufnr) vim.api.nvim_buf_delete(bufnr, { force = true }) end,
            right_mouse_command = function(bufnr) vim.api.nvim_buf_delete(bufnr, { force = true }) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            diagnostics_indicator = function(_, _, diagnostics)
                local icons = {
                    Error = " ",
                    Warn  = " ",
                    Info  = " ",
                }
                local result = ""
                if diagnostics.error then result = result .. icons.Error .. diagnostics.error .. " " end
                if diagnostics.warning then result = result .. icons.Warn .. diagnostics.warning end
                return vim.trim(result)
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
		require('bufferline.groups').builtin.pinned:with({ icon = "󰐃 " })
        -- Fix bufferline after restoring session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(vim.cmd, "BufferLineRefresh")
                end)
            end,
        })
    end,
}
