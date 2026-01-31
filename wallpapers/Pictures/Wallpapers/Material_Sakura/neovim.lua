local h = vim.api.nvim_set_hl

-- 1. FORCE LIGHT MODE (Material Sakura is a Light Theme)
vim.opt.background = "light"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Material Sakura vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#FFF8F9", -- editor.background
	fg = "#201A1B", -- editor.foreground

	-- UI Surfaces
	sidebar = "#FFF0F3", -- sideBar.background
	line_bg = "#FFF0F3", -- editor.lineHighlightBackground
	highlight = "#CBE6FF", -- list.activeSelectionBackground
	selection = "#CBE6FF", -- editor.selectionBackground
	border = "#F3DDE1", -- editorGroup.border
	gutter = "#857377", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#857377", -- COMMENT (Grayish Pink)
	red = "#D04E67", -- KEYWORD / TAG / ERROR (Deep Pink)
	green = "#5E8E6C", -- STRING (Green)
	teal = "#4A8F94", -- ANNOTATION / CLASS (Teal)
	blue = "#4D7AB8", -- FUNCTION (Blue)
	purple = "#8A6A9B", -- DECORATOR (Purple)
	orange = "#C47D48", -- NUMBER / CONSTANT (Orange-Brown)
	brown = "#524346", -- PARAMETERS
	pink_dim = "#E496A6", -- Button Hover / Highlights

	-- Diagnostics
	error = "#D24E65", -- editorError.foreground
	warn = "#C47D48", -- editorWarning.foreground
	info = "#4A8F94", -- editorInfo.foreground
	hint = "#4A8F94", -- Same as Info/Type

	-- Git
	git_add = "#5E8E6C", -- gitDecoration.addedResourceForeground
	git_change = "#4D7AB8", -- gitDecoration.modifiedResourceForeground
	git_delete = "#D24E65", -- gitDecoration.deletedResourceForeground
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
	keyword = colors.red, -- Keywords are Deep Pink
	var = colors.fg, -- Variables are FG
	type = colors.teal, -- Types/Classes are Teal

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
set("CursorLineNr", { fg = colors.red, bold = true }) -- Pink current line

set("Cursor", { fg = colors.bg, bg = "#3F0016" }) -- editorCursor.foreground
set("lCursor", { fg = colors.bg, bg = "#3F0016" })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.selection, fg = "#001E30", bold = true }) -- Based on editor.findMatchBackground
set("IncSearch", { bg = colors.pink_dim, fg = "#3F0016" })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.teal, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = "#001E30", bold = true }) -- Dark blue text on selection
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange }) -- Numbers are Orange/Brown
set("Boolean", { fg = colors.fg, bold = true }) -- Booleans are often Bold FG in this theme style
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword }) -- Operators are Pink/Red
set("Keyword", { fg = c.keyword, bold = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.teal })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = c.type })
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.purple }) -- Decorators/Special are Purple
set("SpecialChar", { fg = colors.orange })
set("Tag", { fg = colors.red }) -- Tags are Red
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.red })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.teal, bold = true })

-- Diagnostics
set("DiagnosticError", { fg = colors.error })
set("DiagnosticWarn", { fg = colors.warn })
set("DiagnosticInfo", { fg = colors.info })
set("DiagnosticHint", { fg = colors.hint })
set("DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
set("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warn })
set("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.info })
set("DiagnosticUnderlineHint", { undercurl = true, sp = colors.hint })

-- Git (Pastel Backgrounds for Light Mode)
set("DiffAdd", { bg = "#EAF5EE" }) -- Pastel Green mix
set("DiffChange", { bg = "#EBF2FA" }) -- Pastel Blue mix
set("DiffDelete", { bg = "#FBEBEC" }) -- Pastel Red mix
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.red, italic = true }) -- Self is Pink/Italic
set("@variable.parameter", { fg = colors.brown }) -- Parameters are Brown
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
set("@punctuation", { fg = c.fg_gutter }) -- Punctuation often gray/pinkish
set("@punctuation.delimiter", { fg = c.fg_gutter })
set("@punctuation.bracket", { fg = c.fg_gutter })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.orange }) -- Constants are Orange
set("@constant.builtin", { fg = colors.orange })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.orange }) -- Attributes often Orange
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.blue, bold = true })
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
	Function = colors.blue,
	Constructor = colors.blue,
	Field = colors.green,
	Variable = colors.red,
	Class = colors.teal,
	Interface = colors.teal,
	Module = colors.blue,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.teal,
	Keyword = colors.red,
	Snippet = colors.purple,
	Color = colors.red,
	File = colors.blue,
	Reference = colors.purple,
	Folder = colors.blue,
	EnumMember = colors.red,
	Constant = colors.orange,
	Struct = colors.teal,
	Event = colors.orange,
	Operator = colors.red,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.blue, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.blue, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.teal, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Material Sakura Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = "#001E30" },
		c = { bg = "NONE", fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = "#001E30" },
		c = { bg = "NONE", fg = colors.fg },
	},
	visual = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = "#001E30" },
		c = { bg = "NONE", fg = colors.fg },
	},
	replace = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = "#001E30" },
		c = { bg = "NONE", fg = colors.fg },
	},
	command = {
		a = { bg = colors.teal, fg = colors.bg, gui = "bold" },
		b = { bg = colors.highlight, fg = "#001E30" },
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
