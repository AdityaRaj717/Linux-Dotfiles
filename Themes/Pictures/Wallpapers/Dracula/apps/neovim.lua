local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Dracula is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Dracula vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#282a36", -- editor.background
	fg = "#f8f8f2", -- editor.foreground (Text)

	-- UI Surfaces
	sidebar = "#282a36", -- sideBar.background
	line_bg = "#44475a", -- editor.lineHighlightBackground
	highlight = "#44475a", -- list.activeSelectionBackground
	selection = "#44475a", -- editor.selectionBackground
	border = "#44475a", -- editorGroup.border
	gutter = "#6272a4", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#6272a4", -- COMMENT
	cyan = "#8be9fd", -- LIBRARY / TYPE / MISC
	green = "#50fa7b", -- FUNCTION / STRING (Dracula uses Green for Functions)
	orange = "#ffb86c", -- PARAMETERS / NUMBER (sometimes)
	pink = "#ff79c6", -- KEYWORD
	purple = "#bd93f9", -- NUMBER / CONSTANT
	red = "#ff5555", -- ERROR / INVALID
	yellow = "#f1fa8c", -- STRING

	-- Diagnostics
	error = "#ff5555", --
	warn = "#f1fa8c", --
	info = "#8be9fd", --
	hint = "#8be9fd", --

	-- Git
	git_add = "#50fa7b", -- gitDecoration.addedResourceForeground
	git_change = "#8be9fd", -- gitDecoration.modifiedResourceForeground
	git_delete = "#ff5555", -- gitDecoration.deletedResourceForeground
}

-- Internal mapping
local c = {
	bg = "NONE", -- Keep transparency setting
	fg = colors.fg,

	-- UI
	bg_highlight = colors.line_bg,
	bg_selection = colors.selection,
	bg_popup = "#1E1F29", -- Slightly darker than BG for popups (Dracula convention)

	fg_gutter = colors.gutter,
	border = colors.border,

	-- Syntax
	comment = colors.comment,
	string = colors.yellow, -- Strings are Yellow in Dracula
	func = colors.green, -- Functions are Green
	keyword = colors.pink, -- Keywords are Pink
	var = colors.fg, -- Variables are FG
	type = colors.cyan, -- Types/Classes are Cyan

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
set("CursorLineNr", { fg = colors.pink, bold = true }) -- Pink current line number

set("Cursor", { fg = colors.bg, bg = colors.fg })
set("lCursor", { fg = colors.bg, bg = colors.fg })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.green, fg = colors.bg, bold = true }) -- Green search
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.cyan, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.cyan, bold = true })
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
set("Operator", { fg = c.keyword })
set("Keyword", { fg = c.keyword, italic = true })
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

set("Special", { fg = colors.pink })
set("SpecialChar", { fg = colors.pink })
set("Tag", { fg = colors.pink }) -- Tags are Pink
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

-- Git (Diff backgrounds estimated for visibility without alpha)
set("DiffAdd", { bg = "#253a30" }) -- Dark Green mix
set("DiffChange", { bg = "#252a3a" }) -- Dark Cyan/Blue mix
set("DiffDelete", { bg = "#3a2525" }) -- Dark Red mix
set("DiffText", { bg = colors.cyan, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.purple, italic = true }) -- "Self" is Purple/Italic
set("@variable.parameter", { fg = colors.orange, italic = true }) -- Parameters are Orange/Italic
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Special" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, italic = true })
set("@keyword.function", { fg = c.type }) -- Keyword 'function' often Cyan in Dracula
set("@operator", { fg = c.keyword })
set("@punctuation", { fg = c.fg_gutter })
set("@punctuation.delimiter", { fg = c.fg_gutter })
set("@punctuation.bracket", { fg = c.fg_gutter })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { link = "Number" }) -- Constants share Purple with Numbers
set("@constant.builtin", { link = "Special" })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.green }) -- Attributes Green
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.cyan, bold = true })
set("TelescopePromptTitle", { bg = colors.pink, fg = colors.bg })
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
	Method = colors.cyan,
	Function = colors.green,
	Constructor = colors.cyan,
	Field = colors.green,
	Variable = colors.fg,
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
	Constant = colors.purple,
	Struct = colors.cyan,
	Event = colors.orange,
	Operator = colors.pink,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.purple, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.cyan, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Dracula Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.purple, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = colors.fg },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
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
