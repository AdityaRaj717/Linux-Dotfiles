local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Monokai is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Monokai vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#191A16", -- editor.background
	fg = "#F8F8F2", -- editor.foreground

	-- UI Surfaces
	sidebar = "#272822", -- sideBar.background
	line_bg = "#272822", -- editor.lineHighlightBackground
	highlight = "#3E3D32", -- list.activeSelectionBackground
	selection = "#3E3D32", -- editor.selectionBackground
	border = "#3E3D32", -- editorGroup.border
	gutter = "#75715E", -- editorLineNumber.foreground
	cursor = "#E6DB74", -- editorCursor.foreground

	-- Syntax (From tokenColors)
	comment = "#75715E", -- COMMENT
	pink = "#F92672", -- KEYWORD / TAG / ERROR
	green = "#A6E22E", -- STRING / INSERTED
	cyan = "#66D9EF", -- FUNCTION / SUPPORT / INFO
	yellow = "#E6DB74", -- CONSTANT / ANNOTATION / CURSOR
	orange = "#FD971F", -- NUMBER / PARAMETER
	white = "#F8F8F2", -- VARIABLE / PARAMETER

	-- Diagnostics
	error = "#F92672", -- editorError.foreground
	warn = "#E6DB74", -- editorWarning.foreground
	info = "#66D9EF", -- editorInfo.foreground
	hint = "#66D9EF", -- editorHint.foreground
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,
	bg_highlight = colors.line_bg,
	bg_selection = colors.selection,
	bg_popup = colors.sidebar,
	fg_gutter = colors.gutter,
	border = colors.border,
}

-- =============================================================================
-- 3. BASE HIGHLIGHTS (Fixed 8-digit hex issues)
-- =============================================================================

-- Editor UI
set("CursorLine", { bg = c.bg_highlight })
set("CursorColumn", { bg = c.bg_highlight })
set("ColorColumn", { bg = c.bg_highlight })

set("LineNr", { fg = c.fg_gutter })
set("CursorLineNr", { fg = colors.yellow, bold = true })

set("Cursor", { fg = colors.bg, bg = colors.cursor })
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

-- [FIX] Used solid 6-digit hex to fix invalid highlight error
set("Search", { bg = colors.highlight, fg = colors.cyan, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.pink, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.cyan, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = colors.comment, italic = true })
set("String", { fg = colors.green })
set("Character", { fg = colors.green })
set("Number", { fg = colors.orange })
set("Boolean", { fg = colors.yellow })
set("Float", { fg = colors.orange })

set("Identifier", { fg = colors.white })
set("Function", { fg = colors.cyan })
set("Statement", { fg = colors.pink })
set("Conditional", { fg = colors.pink })
set("Repeat", { fg = colors.pink })
set("Label", { fg = colors.pink })
set("Operator", { fg = colors.pink })
set("Keyword", { fg = colors.pink, bold = true })
set("Exception", { fg = colors.pink })

set("PreProc", { fg = colors.pink })
set("Include", { fg = colors.pink })
set("Define", { fg = colors.pink })
set("Macro", { fg = colors.cyan })
set("PreCondit", { fg = colors.pink })

set("Type", { fg = colors.cyan })
set("StorageClass", { fg = colors.cyan })
set("Structure", { fg = colors.cyan })
set("Typedef", { fg = colors.cyan })

set("Special", { fg = colors.yellow })
set("SpecialChar", { fg = colors.yellow })
set("Tag", { fg = colors.pink })
set("Delimiter", { fg = colors.fg })
set("Debug", { fg = colors.pink })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.pink })
set("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })

-- Diagnostics
set("DiagnosticError", { fg = colors.error })
set("DiagnosticWarn", { fg = colors.warn })
set("DiagnosticInfo", { fg = colors.info })
set("DiagnosticHint", { fg = colors.hint })

-- [FIX] Notify Setup to resolve background and required field errors
set("NotifyBackground", { bg = colors.bg })
if package.loaded["notify"] then
	require("notify").setup({
		background_colour = colors.bg,
		merge_duplicates = true,
	})
end

-- =============================================================================
-- 4. CMP KIND COLORS & UI
-- =============================================================================
local kinds = {
	Text = colors.green,
	Method = colors.cyan,
	Function = colors.cyan,
	Constructor = colors.cyan,
	Field = colors.green,
	Variable = colors.white,
	Class = colors.cyan,
	Interface = colors.cyan,
	Module = colors.cyan,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.cyan,
	Keyword = colors.pink,
	Snippet = colors.pink,
	Color = colors.pink,
	File = colors.cyan,
	Reference = colors.pink,
	Folder = colors.cyan,
	EnumMember = colors.pink,
	Constant = colors.yellow,
	Struct = colors.cyan,
	Event = colors.orange,
	Operator = colors.pink,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.cyan, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.cyan, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.yellow, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Monokai Style)
-- =============================================================================
local lualine_theme = {
	normal = {
		a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
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
-- 6. BACKGROUND CLEARING (Nuclear Option - Moved to Bottom)
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
