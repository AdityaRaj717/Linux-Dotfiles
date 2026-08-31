local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Abyssal Wave is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Abyssal Wave vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#1a1e29", -- editor.background
	fg = "#e3e6ed", -- editor.foreground

	-- UI Surfaces
	sidebar = "#141720", -- sideBar.background
	line_bg = "#1f232f", -- editor.lineHighlightBackground
	highlight = "#2c313a", -- list.activeSelectionBackground
	selection = "#3e4452", -- editor.inactiveSelectionBackground
	border = "#181a1f", -- editorGroup.border
	gutter = "#4b5263", -- editorLineNumber.foreground
	cursor = "#61afef", -- editorCursor.foreground

	-- Syntax (From tokenColors)
	comment = "#5c667a", -- COMMENT
	blue = "#61afef", -- FUNCTION / INFO
	purple = "#c678dd", -- KEYWORD
	cyan = "#56b6c2", -- DECORATOR / HINT
	red = "#e06c75", -- VARIABLE / TAG / ERROR
	yellow = "#e5c07b", -- ANNOTATION / TYPE / WARN
	green = "#98c379", -- STRING / INSERTED
	orange = "#d69068", -- CONSTANT / NUMBER

	-- Diagnostics
	error = "#e06c75", -- editorError.foreground
	warn = "#e5c07b", -- editorWarning.foreground
	info = "#61afef", -- editorInfo.foreground
	hint = "#56b6c2", -- editorHint.foreground

	-- Git
	git_add = "#98c379", -- gitDecoration.addedResourceForeground
	git_change = "#e5c07b", -- gitDecoration.modifiedResourceForeground
	git_delete = "#e06c75", -- gitDecoration.deletedResourceForeground
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
	string = colors.green, -- Strings are Green
	func = colors.blue, -- Functions are Blue
	keyword = colors.purple, -- Keywords are Purple
	var = colors.red, -- Variables are Coral/Red
	type = colors.yellow, -- Types are Gold

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
set("CursorLineNr", { fg = colors.blue, bold = true }) -- Active line Blue

set("Cursor", { fg = colors.bg, bg = colors.cursor }) -- Cursor is Blue
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = "#2c313a", fg = colors.blue, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.selection, fg = colors.blue, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange }) -- Numbers are Orange
set("Boolean", { fg = colors.orange }) -- Booleans are Orange
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = colors.fg }) -- Operators are standard text color
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

set("Special", { fg = colors.cyan }) -- Decorators are Cyan
set("SpecialChar", { fg = colors.orange })
set("Tag", { fg = colors.red }) -- Tags are Red/Coral
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.purple })

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
set("DiffAdd", { bg = "#1e2e22" }) -- Dark Green mix
set("DiffChange", { bg = "#2e2a1e" }) -- Dark Yellow mix
set("DiffDelete", { bg = "#2e1e1e" }) -- Dark Red mix
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.red, italic = true }) -- Self is Coral/Italic
set("@variable.parameter", { fg = colors.fg }) -- Parameters are Foreground
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Function" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, bold = true })
set("@keyword.function", { fg = c.keyword })
set("@operator", { fg = colors.fg })
set("@punctuation", { fg = colors.fg })
set("@punctuation.delimiter", { fg = colors.fg })
set("@punctuation.bracket", { fg = colors.fg })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.orange }) -- Constants are Orange
set("@constant.builtin", { fg = colors.orange })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.yellow }) -- Attributes often Yellow
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
set("NotifyBackground", { bg = "#1a1e29" })
set("NotifyINFOIcon", { bg = "#1a1e29", fg = colors.info })
set("NotifyINFOTitle", { bg = "#1a1e29", fg = colors.info })
set("NotifyWARNIcon", { bg = colors.bg, fg = colors.warn })
set("NotifyWARNTitle", { bg = colors.bg, fg = colors.warn })
set("NotifyERRORIcon", { bg = colors.bg, fg = colors.error })
set("NotifyERRORTitle", { bg = colors.bg, fg = colors.error })

-- =============================================================================
-- 4. LUALINE THEME (Abyssal Wave Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
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

if package.loaded["notify"] then
	require("notify").setup({
		background_colour = "#1a1e29", -- [FIX] Stops the popup error
	})
end

-- =============================================================================
-- 5. CMP KIND COLORS (Colorful Icons and Menu Labels)
-- =============================================================================
local kinds = {
	Text = colors.green,
	Method = colors.blue,
	Function = colors.blue,
	Constructor = colors.blue,
	Field = colors.green,
	Variable = colors.red,
	Class = colors.yellow,
	Interface = colors.yellow,
	Module = colors.blue,
	Property = colors.green,
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
	Operator = colors.cyan,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

-- UI Enhancements
set("FloatBorder", { fg = colors.blue, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.blue, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 7. BACKGROUND CLEARING (Move this to the VERY BOTTOM)
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
