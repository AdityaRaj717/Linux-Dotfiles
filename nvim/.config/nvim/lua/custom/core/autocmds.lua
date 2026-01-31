-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Handle UI Leave/Enter for terminal colors (from your config)
vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
-- 	callback = function()
-- 		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
-- 		if not normal.bg then
-- 			return
-- 		end
-- 		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
-- 	end,
-- })

-- HTML/CSS Indentation overrides
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "css" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

-- Neotree statusline fix
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			vim.opt_local.statusline = ""
		end
	end,
})

-- [[ Theme Switcher Integration ]]
local theme_loader = require("custom.core.theme_loader")

-- 1. Load theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		theme_loader.load_theme()
	end,
})

-- 2. Live Update: Correctly listen for SIGUSR1 using libuv
local signal = vim.uv.new_signal() -- Use vim.loop.new_signal() if on older Neovim
signal:start("sigusr1", function()
	vim.schedule(function()
		theme_loader.load_theme()
		print("Theme reloaded!")
	end)
end)
