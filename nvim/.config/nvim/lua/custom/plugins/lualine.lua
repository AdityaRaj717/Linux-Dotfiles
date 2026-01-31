return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_theme = {
			normal = {
				a = { bg = "#d4d4d4", fg = "#1c1c1c", gui = "bold" }, -- Light bg for mode
				b = { bg = "#4e4e4e", fg = "#d4d4d4" }, -- Dark gray for git branch
				c = { bg = "NONE", fg = "#808080" }, -- Transparent for filename
				x = { bg = "NONE", fg = "#808080" },
				y = { bg = "NONE", fg = "#808080" },
				z = { bg = "#d4d4d4", fg = "#1c1c1c" }, -- Light bg for filetype
			},
			insert = {
				a = { bg = "#d4d4d4", fg = "#1c1c1c", gui = "bold" },
				b = { bg = "#4e4e4e", fg = "#d4d4d4" },
				c = { bg = "NONE", fg = "#808080" },
				x = { bg = "NONE", fg = "#808080" },
				y = { bg = "NONE", fg = "#808080" },
				z = { bg = "#d4d4d4", fg = "#1c1c1c" },
			},
			visual = {
				a = { bg = "#d4d4d4", fg = "#1c1c1c", gui = "bold" },
				b = { bg = "#4e4e4e", fg = "#d4d4d4" },
				c = { bg = "NONE", fg = "#808080" },
				x = { bg = "NONE", fg = "#808080" },
				y = { bg = "NONE", fg = "#808080" },
				z = { bg = "#d4d4d4", fg = "#1c1c1c" },
			},
			replace = {
				a = { bg = "#d4d4d4", fg = "#1c1c1c", gui = "bold" },
				b = { bg = "#4e4e4e", fg = "#d4d4d4" },
				c = { bg = "NONE", fg = "#808080" },
				x = { bg = "NONE", fg = "#808080" },
				y = { bg = "NONE", fg = "#808080" },
				z = { bg = "#d4d4d4", fg = "#1c1c1c" },
			},
			command = {
				a = { bg = "#d4d4d4", fg = "#1c1c1c", gui = "bold" },
				b = { bg = "#4e4e4e", fg = "#d4d4d4" },
				c = { bg = "NONE", fg = "#808080" },
				x = { bg = "NONE", fg = "#808080" },
				y = { bg = "NONE", fg = "#808080" },
				z = { bg = "#d4d4d4", fg = "#1c1c1c" },
			},
			inactive = {
				a = { bg = "NONE", fg = "#606060" },
				b = { bg = "NONE", fg = "#606060" },
				c = { bg = "NONE", fg = "#606060" },
			},
		}

		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_theme,
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				always_divide_middle = true,
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str
						end,
						padding = { left = 1, right = 1 },
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "󰊢",
						padding = { left = 1, right = 1 },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 0,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[No Name]",
						},
						padding = { left = 1, right = 1 },
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"filetype",
						colored = true,
						icon_only = false,
						padding = { left = 1, right = 1 },
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
