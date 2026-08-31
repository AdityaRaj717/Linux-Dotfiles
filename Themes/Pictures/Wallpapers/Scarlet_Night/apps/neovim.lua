local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Scarlet Night is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Scarlet Night vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#1C1C1E", -- editor.background
	fg = "#E5E5EA", -- editor.foreground

	-- UI Surfaces
	sidebar = "#2C2C2E", -- sideBar.background
	line_bg = "#2C2C2E", -- editor.lineHighlightBackground
	highlight = "#3A3A3C", -- list.activeSelectionBackground
	selection = "#3A3A3C", -- editor.selectionBackground (approx solid from #B84A4F33)
	border = "#3A3A3C", -- editorGroup.border
	gutter = "#8E8E93", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#8E8E93", -- COMMENT (Grey)
	scarlet = "#B84A4F", -- KEYWORD / NUMBER / CONSTANT / TAG
	pink = "#D65D62", -- FUNCTION / ERROR / INVALID
	silver = "#D1D1D6", -- STRING / INFO / DECORATOR
	orange = "#D68C5E", -- ANNOTATION / TYPE (Muted Orange)
	grey = "#8E8E93", -- PARAMETERS
	red_dark = "#8E2F32", -- DELETED / BADGE

	-- Diagnostics
	error = "#D65D62", -- editorError.foreground
	warn = "#B84A4F", -- editorWarning.foreground
	info = "#D1D1D6", -- editorInfo.foreground
	hint = "#D1D1D6", -- Inferred from Info

	-- Git
	git_add = "#D1D1D6", -- gitDecoration.addedResourceForeground
	git_change = "#B84A4F", -- gitDecoration.modifiedResourceForeground
	git_delete = "#8E2F32", -- gitDecoration.deletedResourceForeground
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
	string = colors.silver, -- Strings are Silver
	func = colors.pink, -- Functions are Pink
	keyword = colors.scarlet, -- Keywords are Scarlet
	var = colors.fg, -- Variables are FG
	type = colors.orange, -- Types/Annotations are Orange

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
set("CursorLineNr", { fg = colors.scarlet, bold = true }) -- Active line is Scarlet

set("Cursor", { fg = colors.bg, bg = colors.scarlet }) -- editorCursor.foreground
set("lCursor", { fg = colors.bg, bg = colors.scarlet })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.scarlet, fg = colors.bg, bold = true }) -- Based on match border
set("IncSearch", { bg = colors.pink, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.scarlet, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.scarlet, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.scarlet }) -- Numbers are Scarlet
set("Boolean", { fg = colors.scarlet, bold = true }) -- Booleans are Scarlet
set("Float", { fg = colors.scarlet })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword, bold = true })
set("Conditional", { fg = c.keyword, bold = true })
set("Repeat", { fg = c.keyword, bold = true })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword, bold = true }) -- Operators often Scarlet
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.pink })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = colors.scarlet }) -- Storage modifiers are Scarlet
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.silver }) -- Decorators are Silver
set("SpecialChar", { fg = colors.silver })
set("Tag", { fg = colors.scarlet }) -- Tags are Scarlet
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.pink })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.scarlet, bold = true })

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
set("DiffAdd", { bg = "#2f3832" }) -- Dark Greenish mix
set("DiffChange", { bg = "#3a2c2e" }) -- Dark Scarlet mix
set("DiffDelete", { bg = "#3a1c1e" }) -- Dark Red mix
set("DiffText", { bg = colors.scarlet, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.scarlet, italic = true }) -- Self is Scarlet/Italic
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
set("@punctuation", { fg = colors.grey })
set("@punctuation.delimiter", { fg = colors.grey })
set("@punctuation.bracket", { fg = colors.grey })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.scarlet }) -- Constants are Scarlet
set("@constant.builtin", { fg = colors.scarlet })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.scarlet })
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.scarlet, bold = true })
set("TelescopePromptTitle", { bg = colors.scarlet, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.pink, fg = colors.bg })
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
	Text = colors.silver,
	Method = colors.pink,
	Function = colors.pink,
	Constructor = colors.pink,
	Field = colors.silver,
	Variable = colors.fg,
	Class = colors.orange,
	Interface = colors.orange,
	Module = colors.pink,
	Property = colors.silver,
	Unit = colors.scarlet,
	Value = colors.scarlet,
	Enum = colors.orange,
	Keyword = colors.scarlet,
	Snippet = colors.pink,
	Color = colors.pink,
	File = colors.silver,
	Reference = colors.pink,
	Folder = colors.silver,
	EnumMember = colors.pink,
	Constant = colors.scarlet,
	Struct = colors.orange,
	Event = colors.scarlet,
	Operator = colors.scarlet,
	TypeParameter = colors.orange,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.scarlet, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.scarlet, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.pink, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Scarlet Night Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.scarlet, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.grey },
	},
	insert = {
		a = { bg = colors.silver, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.grey },
	},
	visual = {
		a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.grey },
	},
	replace = {
		a = { bg = colors.red_dark, fg = colors.fg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.grey },
	},
	command = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.grey },
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
