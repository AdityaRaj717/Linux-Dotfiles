local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Greenify vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#0f1412", -- editor.background
	fg = "#e4eee6", -- editor.foreground

	-- UI Surfaces
	sidebar = "#090c0a", -- sideBar.background
	line_bg = "#1f2e26", -- Using 'input.background' / 'list.activeSelection' for visible surface
	highlight = "#1f2e26", -- list.activeSelectionBackground
	selection = "#2a3d33", -- button.hoverBackground / approx selection
	border = "#050806", -- editorGroup.border
	gutter = "#5e7565", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#5e7565", -- COMMENT
	cyan = "#56b6c2", -- FUNCTION / SUPPORT (Cyan)
	green = "#98c379", -- STRING / ANNOTATION (Green)
	orange = "#d19a66", -- KEYWORD / PARAMETER (Orange)
	yellow = "#e5c07b", -- NUMBER / CONSTANT (Yellow)
	red = "#e06c75", -- ERROR / INVALID (Red)
	teal = "#4db6ac", -- DECORATOR / DEBUG TOKEN
	pale_green = "#aebfb4", -- DOCSTRING / META

	-- Diagnostics
	error = "#e06c75", --
	warn = "#e5c07b", --
	info = "#56b6c2", --
	hint = "#4db6ac", --

	-- Git
	git_add = "#98c379", -- gitDecoration.addedResourceForeground
	git_change = "#56b6c2", -- gitDecoration.modifiedResourceForeground
	git_delete = "#e06c75", -- gitDecoration.deletedResourceForeground
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,

	-- UI
	bg_highlight = "#050806", -- editor.lineHighlightBackground
	bg_selection = colors.selection,
	bg_popup = colors.sidebar,

	fg_gutter = colors.gutter,
	border = colors.border,

	-- Syntax
	comment = colors.comment,
	string = colors.green, -- Strings are Green
	func = colors.cyan, -- Functions are Cyan
	keyword = colors.orange, -- Keywords are Orange
	var = colors.fg, -- Variables are FG (#e4eee6)
	type = colors.green, -- Annotations/Types are Green

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
set("CursorLineNr", { fg = colors.green, bold = true }) -- Green current line

set("Cursor", { fg = colors.bg, bg = colors.yellow }) -- Yellow cursor
set("lCursor", { fg = colors.bg, bg = colors.yellow })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.green, fg = colors.bg, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.cyan, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.line_bg, fg = colors.green, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.yellow }) -- Numbers are Yellow
set("Boolean", { fg = colors.cyan }) -- Booleans are Cyan (debugTokenExpression.boolean)
set("Float", { fg = colors.yellow })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword })
set("Keyword", { fg = c.keyword, italic = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.yellow }) -- Macros often Yellow/Orange
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = c.type })
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.teal }) -- Decorators are Teal
set("SpecialChar", { fg = colors.teal })
set("Tag", { fg = colors.red }) -- Tags are Red
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.teal })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.yellow })

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
set("DiffAdd", { bg = "#0f2615" }) -- Dark Green mix
set("DiffChange", { bg = "#0f1f26" }) -- Dark Cyan mix
set("DiffDelete", { bg = "#260f0f" }) -- Dark Red mix
set("DiffText", { bg = colors.cyan, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.red, italic = true }) -- Self/This often Red/Italic in this theme style
set("@variable.parameter", { fg = colors.orange }) -- Parameters are Orange
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Special" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, italic = true })
set("@keyword.function", { fg = c.keyword })
set("@operator", { fg = c.keyword })
set("@punctuation", { fg = c.fg_gutter })
set("@punctuation.delimiter", { fg = c.fg_gutter })
set("@punctuation.bracket", { fg = c.fg_gutter })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { link = "Number" })
set("@constant.builtin", { link = "Special" })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.yellow }) -- Attributes Yellow/Gold
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.green, bold = true })
set("TelescopePromptTitle", { bg = colors.green, fg = colors.bg })
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
	Text = colors.green,
	Method = colors.cyan,
	Function = colors.cyan,
	Constructor = colors.cyan,
	Field = colors.green,
	Variable = colors.fg,
	Class = colors.green,
	Interface = colors.green,
	Module = colors.cyan,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.green,
	Keyword = colors.orange,
	Snippet = colors.green,
	Color = colors.red,
	File = colors.cyan,
	Reference = colors.red,
	Folder = colors.cyan,
	EnumMember = colors.red,
	Constant = colors.yellow,
	Struct = colors.green,
	Event = colors.yellow,
	Operator = colors.orange,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.green, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.green, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Greenify Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.teal, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
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
