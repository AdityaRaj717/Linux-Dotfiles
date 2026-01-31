local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Gruvbox Retro vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#282828", -- editor.background
	fg = "#ebdbb2", -- editor.foreground (Cream)

	-- UI Surfaces
	sidebar = "#282828", -- sideBar.background
	line_bg = "#3c3836", -- editor.lineHighlightBackground
	highlight = "#504945", -- list.activeSelectionBackground
	selection = "#504945", -- editor.selectionBackground (approx stripped of alpha)
	border = "#3c3836", -- editorGroup.border
	gutter = "#928374", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#928374", -- COMMENT (Gray)
	red = "#fb4934", -- KEYWORD / ERROR (Red)
	green = "#b8bb26", -- STRING / FUNCTION (Green)
	yellow = "#fabd2f", -- CLASS / TYPE (Yellow)
	blue = "#83a598", -- FUNCTION PARAMETERS / SUPPORT (Blue)
	purple = "#d3869b", -- NUMBER / CONSTANT (Purple)
	aqua = "#8ec07c", -- DECORATOR (Aqua)
	orange = "#fe8019", -- MISC / NUMBER (Orange)

	-- Diagnostics
	error = "#fb4934", --
	warn = "#fabd2f", --
	info = "#83a598", --
	hint = "#8ec07c", --

	-- Git
	git_add = "#b8bb26", -- gitDecoration.addedResourceForeground
	git_change = "#83a598", -- gitDecoration.modifiedResourceForeground
	git_delete = "#fb4934", -- gitDecoration.deletedResourceForeground
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,

	-- UI
	bg_highlight = colors.line_bg,
	bg_selection = colors.selection,
	bg_popup = "#3c3836", -- Slightly lighter surface for popups

	fg_gutter = colors.gutter,
	border = colors.border,

	-- Syntax
	comment = colors.comment,
	string = colors.green, -- Strings are Green
	func = colors.green, -- Functions are Green
	keyword = colors.red, -- Keywords are Red
	var = colors.fg, -- Variables are FG
	type = colors.yellow, -- Types are Yellow

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
set("CursorLineNr", { fg = colors.yellow, bold = true }) -- Yellow current line

set("Cursor", { fg = colors.bg, bg = colors.fg })
set("lCursor", { fg = colors.bg, bg = colors.fg })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.yellow, fg = colors.bg, bold = true }) -- Retro yellow search
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.green, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.purple }) -- Numbers are Purple
set("Boolean", { fg = colors.purple })
set("Float", { fg = colors.purple })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.fg }) -- Operators often FG or Orange
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.aqua }) -- PreProc often Aqua in Gruvbox
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = colors.orange }) -- Storage often Orange
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.orange }) -- Special chars often Orange
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
set("DiffAdd", { bg = "#263026" }) -- Faint Green
set("DiffChange", { bg = "#262b30" }) -- Faint Blue
set("DiffDelete", { bg = "#302626" }) -- Faint Red
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.purple, italic = true }) -- Self/Builtin often Purple/Italic
set("@variable.parameter", { fg = colors.blue }) -- Parameters are Blue
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Special" }) -- Builtin functions often Aqua/Special
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, bold = true })
set("@keyword.function", { fg = c.keyword })
set("@operator", { link = "Operator" })
set("@punctuation", { fg = c.fg })
set("@punctuation.delimiter", { fg = c.fg })
set("@punctuation.bracket", { fg = c.fg })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { link = "Number" })
set("@constant.builtin", { link = "Special" })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.yellow }) -- Attributes often Yellow
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.green, bold = true })
set("TelescopePromptTitle", { bg = colors.red, fg = colors.bg })
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
-- 4. CMP KIND COLORS & UI
-- =============================================================================
local kinds = {
	Text = colors.green,
	Method = colors.blue,
	Function = colors.green,
	Constructor = colors.blue,
	Field = colors.green,
	Variable = colors.fg,
	Class = colors.yellow,
	Interface = colors.yellow,
	Module = colors.blue,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.yellow,
	Keyword = colors.red,
	Snippet = colors.purple,
	Color = colors.purple,
	File = colors.blue,
	Reference = colors.purple,
	Folder = colors.blue,
	EnumMember = colors.purple,
	Constant = colors.purple,
	Struct = colors.yellow,
	Event = colors.orange,
	Operator = colors.fg,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.yellow, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.yellow, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.orange, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Gruvbox Retro Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
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
