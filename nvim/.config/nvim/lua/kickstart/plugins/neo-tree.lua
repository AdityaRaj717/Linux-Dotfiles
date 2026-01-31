-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
			hijack_netrw_behavior = "open_current",
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
					vim.opt_local.statuscolumn = "" -- Add this to clear your custom statuscolumn
				end,
			},
		},
	},
}
