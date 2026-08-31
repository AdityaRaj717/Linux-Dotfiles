local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Catppuccin Mocha is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Catppuccin Noctis Mocha vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#1e1e2e", -- editor.background (Base)
	fg = "#cdd6f4", -- editor.foreground (Text)

	-- UI Surfaces
	sidebar = "#181825", -- sideBar.background (Mantle)
	line_bg = "#313244", -- editor.lineHighlightBackground (Surface0/1 approx)
	highlight = "#45475a", -- list.activeSelectionBackground (Surface2)
	selection = "#585b70", -- editor.selectionBackground (Surface2/Overlay1)
	border = "#11111b", -- editorGroup.border (Crust)
	gutter = "#7f849c", -- editorLineNumber.foreground (Overlay0)

	-- Syntax (From tokenColors)
	comment = "#6c7086", -- COMMENT (Overlay0)
	cyan = "#94e2d5", -- DECORATOR / MISC (Teal)
	blue = "#89b4fa", -- FUNCTION (Blue)
	purple = "#cba6f7", -- KEYWORD (Mauve)
	orange = "#fab387", -- NUMBER / CONSTANT (Peach)
	yellow = "#f9e2af", -- TYPE / CLASS (Yellow)
	green = "#a6e3a1", -- STRING (Green)
	red = "#f38ba8", -- VARIABLE / TAG / ERROR (Red)

	-- Diagnostics
	error = "#f38ba8", -- Red
	warn = "#f9e2af", -- Yellow
	info = "#89b4fa", -- Blue
	hint = "#94e2d5", -- Teal

	-- Git
	git_add = "#a6e3a1", -- Green
	git_change = "#f9e2af", -- Yellow
	git_delete = "#f38ba8", -- Red
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,

	-- UI
	bg_highlight = colors.line_bg, -- CursorLine
	bg_selection = "#45475a", -- Custom mix for Visual Selection (Surface2)
	bg_popup = colors.sidebar, -- Pmenu / Floats

	fg_gutter = colors.gutter,
	border = colors.border,

	-- Syntax
	comment = colors.comment,
	string = colors.green,
	func = colors.blue,
	keyword = colors.purple,
	var = colors.fg, -- Variable is often text-white in Mocha, or White/Red depending on preference. Keeping standard FG.
	type = colors.yellow,

	-- Git
	git = {
		add = colors.git_add,
		change = colors.git_change,
		delete = colors.git_delete,
	},
}

-- =============================================================================
-- 3. BACKGROUND CLEARING (Nuclear Option)
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
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeWinSeparator",
	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptNormal",
	"TelescopePromptBorder",
	"Pmenu",
	"PmenuSbar",
	"PmenuThumb",
	"NormalFloat",
	"FloatBorder",
}

for _, group in ipairs(transparent_groups) do
	vim.cmd(string.format("hi %s guibg=NONE ctermbg=NONE", group))
end

-- =============================================================================
-- 4. BASE HIGHLIGHTS
-- =============================================================================

-- Editor UI
set("CursorLine", { bg = c.bg_highlight })
set("CursorColumn", { bg = c.bg_highlight })
set("ColorColumn", { bg = c.bg_highlight })

set("LineNr", { fg = c.fg_gutter })
set("CursorLineNr", { fg = colors.blue, bold = true })

set("Cursor", { fg = colors.bg, bg = colors.fg }) -- Invert text/bg for cursor
set("lCursor", { fg = colors.bg, bg = colors.fg })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg }) -- CHANGED: set bg to "NONE"
set("PmenuSel", { bg = colors.highlight, fg = colors.fg, bold = true })
set("PmenuSbar", { bg = "NONE" }) -- CHANGED: set bg to "NONE"
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange })
set("Boolean", { fg = colors.orange })
set("Float", { fg = colors.orange })

set("Identifier", { fg = colors.red }) -- Variables often Red/Pink in Mocha
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword })
set("Keyword", { fg = c.keyword, italic = true })
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

set("Special", { fg = colors.cyan })
set("SpecialChar", { fg = colors.cyan })
set("Tag", { fg = colors.red })
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.orange })

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

-- Git (Darker backgrounds for diffs)
set("DiffAdd", { bg = "#20303b" }) -- Dark Sky/Green mix
set("DiffChange", { bg = "#252b3b" }) -- Dark Blue mix
set("DiffDelete", { bg = "#362128" }) -- Dark Red mix
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.fg })
set("@variable.builtin", { fg = colors.red })
set("@variable.parameter", { fg = colors.orange }) -- Parameters often Peach
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Special" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = colors.yellow })
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
set("@tag.attribute", { fg = colors.orange })
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.blue, bold = true })
set("TelescopePromptTitle", { bg = colors.blue, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.green, fg = colors.bg })
set("TelescopeSelection", { bg = c.bg_highlight, fg = c.fg })
set("GitSignsAdd", { fg = c.git.add, bg = "NONE" })
set("GitSignsChange", { fg = c.git.change, bg = "NONE" })
set("GitSignsDelete", { fg = c.git.delete, bg = "NONE" })

-- [FIX] Explicitly set NotifyBackground to solid color
set("NotifyBackground", { bg = colors.bg })
set("NotifyINFOIcon", { bg = colors.bg, fg = colors.info })
set("NotifyINFOTitle", { bg = colors.bg, fg = colors.info })
set("NotifyWARNIcon", { bg = colors.bg, fg = colors.warn })
set("NotifyWARNTitle", { bg = colors.bg, fg = colors.warn })
set("NotifyERRORIcon", { bg = colors.bg, fg = colors.error })
set("NotifyERRORTitle", { bg = colors.bg, fg = colors.error })

-- =============================================================================
-- 5. LUALINE THEME (Catppuccin Mocha Style)
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

-- =============================================================================
-- 6. CMP KIND COLORS (Icons and Menu Text)
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
	-- This colors the Icon
	set("CmpItemKind" .. kind, { fg = color })
	-- This colors the "Function", "Variable" text on the right
	set("CmpItemMenu" .. kind, { fg = color, italic = true })
end

-- =============================================================================
-- 7. CMP MENU UI ENHANCEMENTS
-- =============================================================================

-- The border color of the menu (e.g., matching your theme's blue)
set("FloatBorder", { fg = colors.blue, bg = "NONE" })

-- Active Selection (The "Frosted" look from your screenshots)
-- This makes the selection bar colorful but slightly subtle
set("PmenuSel", { bg = colors.selection, fg = "NONE", bold = true })

-- Completion Abbreviation Colors
set("CmpItemAbbr", { fg = colors.fg }) -- Default text color
set("CmpItemAbbrMatch", { fg = colors.blue, bold = true }) -- Color for letters you've typed
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bold = true }) -- Fuzzy match color

-- Source label color (the [LSP], [Snippet] part if you use it)
set("CmpItemMenu", { fg = colors.comment, italic = true })
