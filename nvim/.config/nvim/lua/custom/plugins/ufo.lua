return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufReadPost", -- Load after buffer opens
		config = function()
			-- Option 1: Coc-nvim like folding (simple)
			-- vim.o.foldcolumn = '1' -- Set to '0' if you don't want a fold column

			-- Option 2: Customize configuration
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})

			-- Keymaps for opening/closing all folds
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

			-- Helper to show fold lines with counts (Optional: makes it look nicer)
			-- If you skip this handler, ufo uses a default one.
		end,
	},
}
