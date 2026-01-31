local M = {}

function M.load_theme()
	local cache_file = vim.fn.expand("$HOME/.cache/current_theme")
	if vim.fn.filereadable(cache_file) == 0 then
		return
	end

	local f = io.open(cache_file, "r")
	if not f then
		return
	end
	local theme_name = f:read("*all"):gsub("%s+", "")
	f:close()

	local theme_config = vim.fn.expand("$HOME/Pictures/Wallpapers/") .. theme_name .. "/neovim.lua"

	if vim.fn.filereadable(theme_config) == 1 then
		-- Clear existing highlights to prevent color bleeding
		vim.cmd("hi clear")
		if vim.fn.exists("syntax_on") then
			vim.cmd("syntax reset")
		end

		vim.g.colors_name = theme_name

		-- Execute the theme file
		local success, err = pcall(dofile, theme_config)
		if not success then
			print("Error loading theme " .. theme_name .. ": " .. err)
		end
	end
end

return M
