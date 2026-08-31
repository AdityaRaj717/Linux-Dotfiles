local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Synth Wave is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Synth Wave vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#13091D", -- editor.background
	fg = "#E0E6ED", -- editor.foreground

	-- UI Surfaces
	sidebar = "#1E122E", -- sideBar.background
	line_bg = "#1E122E", -- editor.lineHighlightBackground
	highlight = "#3B2054", -- list.activeSelectionBackground
	selection = "#3B2054", -- editor.selectionBackground
	border = "#3B2054", -- editorGroup.border
	gutter = "#685E79", -- editorLineNumber.foreground
	cursor = "#FF2A6D", -- editorCursor.foreground

	-- Syntax (From tokenColors)
	comment = "#685E79", -- COMMENT
	pink = "#FF2A6D", -- KEYWORD / TAG / SELF
	cyan = "#05D9E8", -- FUNCTION / CLASS / DECORATOR
	orange = "#FF9E00", -- STRING / WARNING
	purple = "#D300C5", -- NUMBER / CONSTANT
	red = "#FF0055", -- ERROR / INVALID
	text = "#E0E6ED", -- VARIABLE

	-- Diagnostics
	error = "#FF0055", -- editorError.foreground
	warn = "#FF9E00", -- editorWarning.foreground
	info = "#05D9E8", -- editorInfo.foreground
	hint = "#05D9E8", -- editorHint.foreground

	-- Git
	git_add = "#05D9E8", -- gitDecoration.addedResourceForeground
	git_change = "#FF9E00", -- gitDecoration.modifiedResourceForeground
	git_delete = "#FF0055", -- gitDecoration.deletedResourceForeground
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
	func = colors.cyan, -- Functions are Cyan
	keyword = colors.pink, -- Keywords are Pink
	var = colors.text, -- Variables are FG
	type = colors.cyan, -- Classes are Cyan

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
set("CursorLineNr", { fg = colors.pink, bold = true }) -- Active line Pink

set("Cursor", { fg = colors.bg, bg = colors.cursor }) -- Cursor is Pink
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.pink, fg = colors.bg, bold = true }) -- Pink search background
set("IncSearch", { bg = colors.cyan, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.cyan, bold = true }) -- Cyan text on selection
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.purple }) -- Numbers are Purple
set("Boolean", { fg = colors.orange }) -- Booleans are Orange
set("Float", { fg = colors.purple })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword })
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.pink })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = c.type })
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.cyan }) -- Decorators are Cyan
set("SpecialChar", { fg = colors.cyan })
set("Tag", { fg = colors.pink }) -- Tags are Pink
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.red })

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
set("DiffAdd", { bg = "#0d2b2f" }) -- Cyan tinted dark bg
set("DiffChange", { bg = "#2f1f0d" }) -- Orange tinted dark bg
set("DiffDelete", { bg = "#2f0d1a" }) -- Pink/Red tinted dark bg
set("DiffText", { bg = colors.cyan, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.pink, italic = true }) -- Self is Pink/Italic
set("@variable.parameter", { fg = c.fg }) -- Parameters are FG
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
set("@constant", { fg = colors.purple }) -- Constants are Purple
set("@constant.builtin", { fg = colors.purple })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.cyan }) -- Attributes often Cyan
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.pink, bold = true })
set("TelescopePromptTitle", { bg = colors.pink, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.cyan, fg = colors.bg })
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
	Text = colors.text,
	Method = colors.cyan,
	Function = colors.cyan,
	Constructor = colors.cyan,
	Field = colors.cyan,
	Variable = colors.text,
	Class = colors.cyan,
	Interface = colors.cyan,
	Module = colors.cyan,
	Property = colors.cyan,
	Unit = colors.purple,
	Value = colors.purple,
	Enum = colors.cyan,
	Keyword = colors.pink,
	Snippet = colors.pink,
	Color = colors.pink,
	File = colors.cyan,
	Reference = colors.pink,
	Folder = colors.cyan,
	EnumMember = colors.pink,
	Constant = colors.purple,
	Struct = colors.cyan,
	Event = colors.purple,
	Operator = colors.pink,
	TypeParameter = colors.cyan,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.pink, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.pink, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Synth Wave Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
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
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
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
-- 6. BACKGROUND CLEARING (Nuclear Option)
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
