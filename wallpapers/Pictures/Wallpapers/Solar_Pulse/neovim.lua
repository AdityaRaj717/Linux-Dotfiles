local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Solar Pulse is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Solar Pulse vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#0B0F19", -- editor.background
	fg = "#EAE2B7", -- editor.foreground

	-- UI Surfaces
	sidebar = "#1C212E", -- sideBar.background
	line_bg = "#1C212E", -- editor.lineHighlightBackground
	highlight = "#2D3142", -- list.activeSelectionBackground
	selection = "#2D3142", -- editor.selectionBackground
	border = "#2D3142", -- editorGroup.border
	gutter = "#8D99AE", -- editorLineNumber.foreground
	cursor = "#FFB300", -- editorCursor.foreground

	-- Syntax (From tokenColors)
	comment = "#8D99AE", -- COMMENT
	blue = "#457B9D", -- FUNCTION / DEBUG INFO / GREEN
	purple = "#6D597A", -- KEYWORD
	yellow = "#FFB300", -- STRING / TYPE / CLASS
	orange = "#FF5F1F", -- NUMBER / CONSTANT
	red = "#D32F2F", -- TAG / ERROR / SELF
	grey = "#8D99AE", -- PARAMETER

	-- Diagnostics
	error = "#D32F2F", -- editorError.foreground
	warn = "#FFB300", -- editorWarning.foreground
	info = "#457B9D", -- editorInfo.foreground
	hint = "#457B9D", -- editorHint.foreground

	-- Git
	git_add = "#457B9D", -- gitDecoration.addedResourceForeground
	git_change = "#FFB300", -- gitDecoration.modifiedResourceForeground
	git_delete = "#D32F2F", -- gitDecoration.deletedResourceForeground
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
	string = colors.yellow, -- Strings are Yellow
	func = colors.blue, -- Functions are Blue
	keyword = colors.purple, -- Keywords are Purple
	var = colors.fg, -- Variables are FG
	type = colors.yellow, -- Classes/Types are Yellow

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
set("CursorLineNr", { fg = colors.orange, bold = true }) -- Active line Number Orange

set("Cursor", { fg = colors.bg, bg = colors.cursor }) -- Cursor is Yellow
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.orange, fg = colors.bg, bold = true }) -- Orange search background
set("IncSearch", { bg = colors.yellow, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.orange, bold = true }) -- Orange text on selection
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange }) -- Numbers are Orange
set("Boolean", { fg = colors.yellow }) -- Booleans are Yellow
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword })
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.purple })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = c.type })
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.blue }) -- Decorators are Blue
set("SpecialChar", { fg = colors.orange })
set("Tag", { fg = colors.red }) -- Tags are Red
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.red })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })

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
set("DiffAdd", { bg = "#0B1915" })
set("DiffChange", { bg = "#19150B" })
set("DiffDelete", { bg = "#190B0B" })
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.red, italic = true }) -- Self is Red/Italic
set("@variable.parameter", { fg = colors.grey }) -- Parameters are Grey
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
set("@punctuation", { fg = c.fg_gutter })
set("@punctuation.delimiter", { fg = c.fg_gutter })
set("@punctuation.bracket", { fg = c.fg_gutter })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.orange }) -- Constants are Orange
set("@constant.builtin", { fg = colors.orange })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.yellow }) -- Attributes often Yellow/Orange
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.blue, bold = true })
set("TelescopePromptTitle", { bg = colors.orange, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.blue, fg = colors.bg })
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
-- 4. CMP KIND COLORS & UI
-- =============================================================================
local kinds = {
	Text = colors.blue,
	Method = colors.blue,
	Function = colors.blue,
	Constructor = colors.blue,
	Field = colors.blue,
	Variable = colors.fg,
	Class = colors.yellow,
	Interface = colors.yellow,
	Module = colors.blue,
	Property = colors.blue,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.yellow,
	Keyword = colors.purple,
	Snippet = colors.red,
	Color = colors.red,
	File = colors.blue,
	Reference = colors.red,
	Folder = colors.blue,
	EnumMember = colors.red,
	Constant = colors.orange,
	Struct = colors.yellow,
	Event = colors.orange,
	Operator = colors.purple,
	TypeParameter = colors.blue,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.orange, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.orange, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.yellow, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Solar Pulse Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" }, -- Orange for Insert
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.purple, fg = colors.bg, gui = "bold" }, -- Purple for Visual
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
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
