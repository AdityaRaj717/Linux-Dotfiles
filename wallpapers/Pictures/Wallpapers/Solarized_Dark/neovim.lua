local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Solarized Dark is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Solarized Dark vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#002B36", -- editor.background (Base03)
	fg = "#839496", -- editor.foreground (Base0)

	-- UI Surfaces
	sidebar = "#073642", -- sideBar.background (Base02)
	line_bg = "#073642", -- editor.lineHighlightBackground
	highlight = "#073642", -- list.activeSelectionBackground
	selection = "#586E75", -- editor.selectionHighlightBackground (Base01 approx)
	border = "#073642", -- editorGroup.border
	gutter = "#586E75", -- editorLineNumber.foreground (Base01)
	cursor = "#B58900", -- editorCursor.foreground (Yellow)

	-- Syntax (From tokenColors)
	comment = "#586E75", -- COMMENT (Base01)
	cyan = "#2AA198", -- KEYWORD / DECORATOR (Cyan)
	blue = "#268BD2", -- FUNCTION / TAG (Blue)
	yellow = "#B58900", -- STRING / ANNOTATION / TYPE (Yellow)
	orange = "#CB4B16", -- NUMBER / CONSTANT / ERROR (Orange)
	magenta = "#D33682", -- terminal.ansiMagenta
	violet = "#6C71C4", -- Standard Solarized Violet
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,
	bg_highlight = colors.line_bg,
	bg_selection = colors.highlight,
	bg_popup = colors.sidebar,
	fg_gutter = colors.gutter,
	border = colors.border,
}

-- =============================================================================
-- 3. BASE HIGHLIGHTS
-- =============================================================================

-- Editor UI
set("CursorLine", { bg = c.bg_highlight })
set("CursorColumn", { bg = c.bg_highlight })
set("ColorColumn", { bg = c.bg_highlight })

set("LineNr", { fg = c.fg_gutter })
set("CursorLineNr", { fg = colors.yellow, bold = true })

set("Cursor", { fg = colors.bg, bg = colors.cursor })
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = colors.highlight, reverse = true }) -- Solarized style reverse
set("VisualNOS", { bg = colors.highlight, reverse = true })

set("Search", { bg = "#073642", fg = colors.cyan, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.cyan, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = colors.comment, italic = true })
set("String", { fg = colors.yellow })
set("Character", { fg = colors.yellow })
set("Number", { fg = colors.orange })
set("Boolean", { fg = colors.yellow })
set("Float", { fg = colors.orange })

set("Identifier", { fg = colors.fg })
set("Function", { fg = colors.blue })
set("Statement", { fg = colors.cyan })
set("Conditional", { fg = colors.cyan })
set("Repeat", { fg = colors.cyan })
set("Label", { fg = colors.cyan })
set("Operator", { fg = colors.cyan })
set("Keyword", { fg = colors.cyan, bold = true })
set("Exception", { fg = colors.cyan })

set("PreProc", { fg = colors.orange })
set("Type", { fg = colors.yellow })
set("StorageClass", { fg = colors.cyan })
set("Structure", { fg = colors.yellow })

set("Special", { fg = colors.orange })
set("Tag", { fg = colors.blue })
set("Delimiter", { fg = colors.fg })
set("Debug", { fg = colors.orange })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.orange })
set("Todo", { fg = colors.magenta, bold = true })

-- Diagnostics
set("DiagnosticError", { fg = colors.orange })
set("DiagnosticWarn", { fg = colors.yellow })
set("DiagnosticInfo", { fg = colors.blue })
set("DiagnosticHint", { fg = colors.cyan })

-- Notify Setup
set("NotifyBackground", { bg = colors.bg })
if package.loaded["notify"] then
	require("notify").setup({
		background_colour = colors.bg,
		merge_duplicates = true,
	})
end

-- =============================================================================
-- 4. CMP KIND COLORS & UI (Colorful icons and labels)
-- =============================================================================
local kinds = {
	Text = colors.fg,
	Method = colors.blue,
	Function = colors.blue,
	Constructor = colors.blue,
	Field = colors.cyan,
	Variable = colors.violet,
	Class = colors.yellow,
	Interface = colors.yellow,
	Module = colors.cyan,
	Property = colors.cyan,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.yellow,
	Keyword = colors.cyan,
	Snippet = colors.magenta,
	Color = colors.magenta,
	File = colors.blue,
	Reference = colors.magenta,
	Folder = colors.blue,
	EnumMember = colors.magenta,
	Constant = colors.orange,
	Struct = colors.yellow,
	Event = colors.orange,
	Operator = colors.cyan,
	TypeParameter = colors.yellow,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.blue, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.cyan, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME
-- =============================================================================
local lualine_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.magenta, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	replace = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	inactive = {
		a = { bg = "NONE", fg = colors.comment },
		b = { bg = "NONE", fg = colors.comment },
		c = { bg = "NONE", fg = colors.comment },
	},
}

if package.loaded["lualine"] then
	require("lualine").setup({
		options = {
			theme = lualine_theme,
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
	})
end

-- =============================================================================
-- 6. BACKGROUND CLEARING (Nuclear Option - Moved to bottom)
-- =============================================================================
local transparent_groups = {
	"Normal",
	"NormalNC",
	"NormalSB",
	"NormalFloat",
	"SignColumn",
	"SignColumnSB",
	"LineNr",
	"CursorLineNr",
	"StatusLine",
	"StatusLineNC",
	"WinBar",
	"WinBarNC",
	"VertSplit",
	"WinSeparator",
	"FloatBorder",
	"Pmenu",
	"PmenuSbar",
	"PmenuThumb",
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeWinSeparator",
	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptNormal",
	"TelescopePromptBorder",
}

for _, group in ipairs(transparent_groups) do
	vim.cmd(string.format("hi %s guibg=NONE ctermbg=NONE", group))
end
