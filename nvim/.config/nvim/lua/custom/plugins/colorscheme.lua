return {
	{ -- You can easily change to a different colorscheme.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("tokyonight").setup({
				styles = {
					comments = { italic = true }, -- Disable italics in comments
				},
			})
			-- Load the colorscheme here.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				highlights = {
					Comment = { italic = true },
					Directory = { bold = true },
					ErrorMsg = { italic = true, bold = true },
				},
				styles = {
					types = "NONE",
					methods = "NONE",
					numbers = "NONE",
					strings = "NONE",
					comments = "italic",
					keywords = "bold,italic",
					constants = "NONE",
					functions = "italic",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "NONE",
				},
			})
		end,
	},
}
