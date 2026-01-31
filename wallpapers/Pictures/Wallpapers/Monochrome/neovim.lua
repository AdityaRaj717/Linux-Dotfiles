local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Graphite Mono is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Graphite Mono vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#0a0a0a", -- editor.background
	fg = "#cccccc", -- editor.foreground

	-- UI Surfaces
	sidebar = "#050505", -- sideBar.background
	line_bg = "#141414", -- editor.lineHighlightBackground
	highlight = "#1f1f1f", -- list.activeSelectionBackground
	selection = "#333333", -- editor.selectionBackground
	border = "#141414", -- editorGroup.border
	gutter = "#404040", -- editorLineNumber.foreground

	-- Syntax (From tokenColors - STRICT MONOCHROME)
	comment = "#505050", -- COMMENT
	white = "#ffffff", -- KEYWORD / CONSTANT / TAG
	gray_light = "#e6e6e6", -- NUMBER / FUNCTION / ANNOTATION
	gray_medium = "#cccccc", -- TEXT / VARIABLE
	gray_dim = "#999999", -- STRING / SELF
	gray_dark = "#aaaaaa", -- PARAMETERS / MISC
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
-- 3. BASE HIGHLIGHTS
-- =============================================================================

-- Editor UI
set("CursorLine", { bg = c.bg_highlight })
set("CursorColumn", { bg = c.bg_highlight })
set("ColorColumn", { bg = c.bg_highlight })

set("LineNr", { fg = c.fg_gutter })
set("CursorLineNr", { fg = colors.white, bold = true })

set("Cursor", { fg = colors.bg, bg = colors.white })
set("lCursor", { fg = colors.bg, bg = colors.white })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.highlight, fg = colors.white, bold = true })
set("IncSearch", { bg = colors.selection, fg = colors.white })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.white, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.white, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax (Monochrome Logic)
set("Comment", { fg = colors.comment, italic = true })
set("String", { fg = colors.gray_dim })
set("Character", { fg = colors.gray_dim })
set("Number", { fg = colors.gray_light })
set("Boolean", { fg = colors.white, bold = true })
set("Float", { fg = colors.gray_light })

set("Identifier", { fg = colors.gray_medium })
set("Function", { fg = colors.gray_light })
set("Statement", { fg = colors.white, bold = true })
set("Conditional", { fg = colors.white, bold = true })
set("Repeat", { fg = colors.white, bold = true })
set("Label", { fg = colors.white })
set("Operator", { fg = colors.white, bold = true })
set("Keyword", { fg = colors.white, bold = true })
set("Exception", { fg = colors.white })

set("PreProc", { fg = colors.white, bold = true })
set("Type", { fg = colors.gray_light })
set("StorageClass", { fg = colors.white })
set("Structure", { fg = colors.gray_light })
set("Typedef", { fg = colors.gray_light })

set("Special", { fg = colors.white })
set("Tag", { fg = colors.white })
set("Delimiter", { fg = colors.gray_medium })
set("Debug", { fg = colors.white })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.gray_light })
set("Todo", { fg = colors.bg, bg = colors.white, bold = true })

-- Diagnostics
set("DiagnosticError", { fg = colors.white })
set("DiagnosticWarn", { fg = colors.gray_light })
set("DiagnosticInfo", { fg = colors.gray_dark })
set("DiagnosticHint", { fg = colors.gray_dark })

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
	Text = colors.gray_medium,
	Method = colors.gray_light,
	Function = colors.gray_light,
	Constructor = colors.gray_light,
	Field = colors.gray_medium,
	Variable = colors.gray_medium,
	Class = colors.white,
	Interface = colors.white,
	Module = colors.gray_light,
	Property = colors.gray_medium,
	Unit = colors.gray_dark,
	Value = colors.gray_dark,
	Enum = colors.white,
	Keyword = colors.white,
	Snippet = colors.white,
	Color = colors.white,
	File = colors.gray_light,
	Reference = colors.white,
	Folder = colors.gray_light,
	EnumMember = colors.white,
	Constant = colors.white,
	Struct = colors.white,
	Event = colors.white,
	Operator = colors.white,
	TypeParameter = colors.gray_light,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.white, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.white, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.gray_light, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Monochrome Style)
-- =============================================================================
local lualine_theme = {
	normal = {
		a = { bg = colors.white, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.white },
		c = { bg = "NONE", fg = colors.gray_dim },
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
