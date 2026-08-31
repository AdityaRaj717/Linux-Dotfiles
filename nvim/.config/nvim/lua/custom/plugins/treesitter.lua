return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- [FIX] Pin to master branch to fix "configs" module error
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- [FIX] We manually require the module here to avoid 'main' config issues
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			configs.setup({
				ensure_installed = {
					"python",
					"go",
					"bash",
					"c",
					"javascript",
					"css",
					"html",
					"typescript",
					"tsx",
					"diff",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			})
		end,
	},
}
