return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- NvChad exact colors
			local colors = {
				blue = "#89b4fa",
				cyan = "#89dceb",
				black = "#1e1e2e",
				white = "#cdd6f4",
				red = "#f38ba8",
				violet = "#cba6f7",
				grey = "#313244",
				green = "#a6e3a1",
				yellow = "#f9e2af",
			}

			local mode_color = {
				n = colors.blue,
				i = colors.red,
				v = colors.violet,
				[""] = colors.violet,
				V = colors.violet,
				c = colors.yellow,
				no = colors.red,
				s = colors.yellow,
				S = colors.yellow,
				[""] = colors.yellow,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.green,
			}

			local nvchad_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.blue, gui = "bold" },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white, bg = "NONE" },
				},
				insert = {
					a = { fg = colors.black, bg = colors.red, gui = "bold" },
				},
				visual = {
					a = { fg = colors.black, bg = colors.violet, gui = "bold" },
				},
				replace = {
					a = { fg = colors.black, bg = colors.red, gui = "bold" },
				},
				command = {
					a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
				},
				inactive = {
					a = { fg = colors.white, bg = colors.grey },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white, bg = "NONE" },
				},
			}

			require("lualine").setup({
				options = {
					theme = nvchad_theme,
					component_separators = "",
					section_separators = { left = "", right = "" },
					globalstatus = true,
					disabled_filetypes = {
						statusline = { "alpha", "dashboard", "NvimTree", "Outline" },
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								-- Just show the first letter of the mode (N, I, V, etc.)
								return " " .. str:sub(1, 1) .. " "
							end,
						},
					},
					lualine_b = {
						{
							"filename",
							color = function()
								return { bg = mode_color[vim.fn.mode()], fg = colors.black, gui = "bold" }
							end,
							padding = { left = 2, right = 2 },
						},
					},
					lualine_c = {
						{
							"branch",
							icon = "", -- Added the git branch icon
							padding = { left = 2, right = 1 },
						},
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.yellow },
								removed = { fg = colors.red },
							},
							padding = { left = 0, right = 1 },
						},
					},
					lualine_x = {
						{
							function()
								return "UTF-8"
							end,
							padding = { left = 1, right = 1 },
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " " },
							diagnostics_color = {
								error = { fg = colors.red },
								warn = { fg = colors.yellow },
								info = { fg = colors.cyan },
							},
							padding = { left = 0, right = 1 },
						},
						{
							function()
								-- [FIXED] Use get_clients instead of get_active_clients
								local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
								if #buf_clients == 0 then
									return " LSP: None"
								end
								local buf_client_names = {}
								for _, client in pairs(buf_clients) do
									if client.name ~= "null-ls" and client.name ~= "copilot" then
										table.insert(buf_client_names, client.name)
									end
								end
								if #buf_client_names == 0 then
									return " LSP: None"
								end
								return " LSP: " .. table.concat(buf_client_names, ", ")
							end,
							color = { bg = colors.green, fg = colors.black, gui = "bold" },
							padding = { left = 1, right = 1 },
							separator = { left = "" },
						},
					},
					lualine_y = {
						{
							"filetype",
							colored = false,
							icon_only = false,
							color = { bg = colors.violet, fg = colors.black, gui = "bold" },
							padding = { left = 2, right = 2 },
							separator = { left = "" },
						},
					},
					lualine_z = {
						{
							"location",
							fmt = function()
								local line = vim.fn.line(".")
								local total = vim.fn.line("$")
								return string.format("%d/%d", line, total)
							end,
							color = { bg = colors.yellow, fg = colors.black, gui = "bold" },
							padding = { left = 2, right = 2 },
							separator = { left = "" },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {},
			})
		end,
	},
}
