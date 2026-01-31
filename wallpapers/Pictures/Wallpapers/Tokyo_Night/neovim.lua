local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Tokyo Night is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Tokyo Night vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#1a1b26", -- editor.background
	fg = "#c0caf5", -- editor.foreground

	-- UI Surfaces
	sidebar = "#24283b", -- sideBar.background
	line_bg = "#24283b", -- editor.lineHighlightBackground
	highlight = "#364A82", -- list.activeSelectionBackground
	selection = "#364A82", -- editor.selectionBackground
	border = "#16161e", -- editorGroup.border
	gutter = "#565f89", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#565f89", -- COMMENT
	cyan = "#7dcfff", -- KEYWORD / IDENTIFIER / TAG
	blue = "#7aa2f7", -- FUNCTION
	purple = "#bb9af7", -- DECORATOR / CLASS / TYPE
	orange = "#ff9e64", -- STRING / NUMBER / CONSTANT
	red = "#f7768e", -- ANNOTATION / ERROR / SELF
	green = "#9ece6a", -- BRACKET HIGHLIGHT / CHARTS

	-- Diagnostics
	error = "#f7768e", -- editorError.foreground
	warn = "#ff9e64", -- editorWarning.foreground
	info = "#7dcfff", -- editorInfo.foreground
	hint = "#7aa2f7", -- editorHint.foreground

	-- Git
	git_add = "#9ece6a", -- gitDecoration.addedResourceForeground
	git_change = "#7dcfff", -- gitDecoration.modifiedResourceForeground
	git_delete = "#f7768e", -- gitDecoration.deletedResourceForeground
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,

	-- UI
	bg_highlight = colors.line_bg,
	bg_selection = colors.selection,
	bg_popup = colors.sidebar,

	fg_gutter = colors.gutter,
	border = colors.border,

	-- Syntax
	comment = colors.comment,
	string = colors.orange, -- Strings are Orange
	func = colors.blue, -- Functions are Blue
	keyword = colors.cyan, -- Keywords are Cyan
	var = colors.fg, -- Variables are Text Foreground
	type = colors.purple, -- Types/Classes are Purple

	-- Git
	git = {
		add = colors.git_add,
		change = colors.git_change,
		delete = colors.git_delete,
	},
}

-- =============================================================================
-- 3. BASE HIGHLIGHTS
-- =============================================================================

-- Editor UI
set("CursorLine", { bg = c.bg_highlight })
set("CursorColumn", { bg = c.bg_highlight })
set("ColorColumn", { bg = c.bg_highlight })

set("LineNr", { fg = c.fg_gutter })
set("CursorLineNr", { fg = colors.cyan, bold = true }) -- Active line Cyan

set("Cursor", { fg = colors.bg, bg = colors.cyan }) -- editorCursor.foreground
set("lCursor", { fg = colors.bg, bg = colors.cyan })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.cyan, fg = colors.bg, bold = true }) -- editor.findMatchBackground
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.cyan, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange }) -- Numbers are Orange
set("Boolean", { fg = colors.orange }) -- Booleans are Orange
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.fg })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword, bold = true }) -- Operators are Cyan/Bold
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.cyan })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = colors.cyan, bold = true }) -- Modifier are Cyan/Bold
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.purple }) -- Decorators are Purple
set("SpecialChar", { fg = colors.orange })
set("Tag", { fg = colors.red }) -- Tags are Red
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.purple })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.orange, bold = true })

-- Diagnostics
set("DiagnosticError", { fg = colors.error })
set("DiagnosticWarn", { fg = colors.warn })
set("DiagnosticInfo", { fg = colors.info })
set("DiagnosticHint", { fg = colors.hint })
set("DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
set("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warn })
set("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.info })
set("DiagnosticUnderlineHint", { undercurl = true, sp = colors.hint })

-- Git
set("DiffAdd", { bg = "#283B2D" }) -- Dark Green mix
set("DiffChange", { bg = "#273445" }) -- Dark Blue mix
set("DiffDelete", { bg = "#3D2C2E" }) -- Dark Red mix
set("DiffText", { bg = colors.cyan, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.red, italic = true }) -- Self is Red/Italic
set("@variable.parameter", { fg = colors.orange }) -- Parameters are Orange
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Function" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, bold = true })
set("@keyword.function", { fg = c.keyword })
set("@operator", { fg = c.keyword })
set("@punctuation", { fg = c.fg })
set("@punctuation.delimiter", { fg = c.fg })
set("@punctuation.bracket", { fg = c.fg })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.orange }) -- Constants are Orange
set("@constant.builtin", { fg = colors.orange })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.purple }) -- Attributes often Purple
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.blue, bold = true })
set("TelescopePromptTitle", { bg = colors.blue, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.green, fg = colors.bg })
set("TelescopeSelection", { bg = c.bg_highlight, fg = c.fg })
set("GitSignsAdd", { fg = c.git.add, bg = "NONE" })
set("GitSignsChange", { fg = c.git.change, bg = "NONE" })
set("GitSignsDelete", { fg = c.git.delete, bg = "NONE" })

-- [FIX] Explicitly set NotifyBackground
set("NotifyBackground", { bg = colors.bg })
set("NotifyINFOIcon", { bg = colors.bg, fg = colors.info })
set("NotifyINFOTitle", { bg = colors.bg, fg = colors.info })
set("NotifyWARNIcon", { bg = colors.bg, fg = colors.warn })
set("NotifyWARNTitle", { bg = colors.bg, fg = colors.warn })
set("NotifyERRORIcon", { bg = colors.bg, fg = colors.error })
set("NotifyERRORTitle", { bg = colors.bg, fg = colors.error })

-- =============================================================================
-- 4. CMP KIND COLORS & UI (Styled from Reference Images)
-- =============================================================================
local kinds = {
	Text = colors.fg,
	Method = colors.blue,
	Function = colors.blue,
	Constructor = colors.blue,
	Field = colors.green,
	Variable = colors.red,
	Class = colors.purple,
	Interface = colors.purple,
	Module = colors.cyan,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.purple,
	Keyword = colors.cyan,
	Snippet = colors.orange,
	Color = colors.red,
	File = colors.cyan,
	Reference = colors.red,
	Folder = colors.cyan,
	EnumMember = colors.red,
	Constant = colors.orange,
	Struct = colors.purple,
	Event = colors.orange,
	Operator = colors.cyan,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.blue, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.cyan, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Tokyo Night Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.purple, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	inactive = {
		a = { bg = "NONE", fg = c.comment },
		b = { bg = "NONE", fg = c.comment },
		c = { bg = "NONE", fg = c.comment },
	},
}

-- SAFELY RELOAD LUALINE
if package.loaded["lualine"] then
	require("lualine").setup({
		options = {
			theme = lualine_theme,
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = {}, winbar = {} },
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
