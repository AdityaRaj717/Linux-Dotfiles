local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Rose Pine is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Rose Pine vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#191724", -- editor.background
	fg = "#e0def4", -- editor.foreground

	-- UI Surfaces
	sidebar = "#1f1d2e", -- sideBar.background
	line_bg = "#26233a", -- editor.lineHighlightBackground
	highlight = "#403d52", -- editor.selectionBackground
	selection = "#403d52", -- editor.selectionBackground
	border = "#26233a", -- editorGroup.border
	gutter = "#908caa", -- editorLineNumber.foreground
	cursor = "#f6c177", -- editorCursor.foreground

	-- Syntax (From tokenColors)
	comment = "#908caa", -- COMMENT
	iris = "#c4a7e7", -- KEYWORD / DEBUG TOKEN
	love = "#eb6f92", -- FUNCTION / ERROR / INVALID
	gold = "#f6c177", -- STRING / WARNING
	foam = "#9ccfd8", -- ANNOTATION / CLASS / TAG
	rose = "#ea9a97", -- NUMBER / CONSTANT
	text = "#e0def4", -- VARIABLE / TEXT
	subtle = "#908caa", -- PARAMETERS / META

	-- Diagnostics
	error = "#eb6f92", -- editorError.foreground
	warn = "#f6c177", -- editorWarning.foreground
	info = "#9ccfd8", -- editorInfo.foreground
	hint = "#9ccfd8", -- editorHint.foreground

	-- Git
	git_add = "#9ccfd8", -- gitDecoration.addedResourceForeground
	git_change = "#f6c177", -- gitDecoration.modifiedResourceForeground
	git_delete = "#eb6f92", -- gitDecoration.deletedResourceForeground
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
	string = colors.gold, -- Strings are Gold
	func = colors.love, -- Functions are Love
	keyword = colors.iris, -- Keywords are Iris
	var = colors.text, -- Variables are Text
	type = colors.foam, -- Types are Foam

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
set("CursorLineNr", { fg = colors.fg, bold = true }) -- Active line number FG

set("Cursor", { fg = colors.bg, bg = colors.cursor }) -- Cursor is Gold
set("lCursor", { fg = colors.bg, bg = colors.cursor })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.highlight, fg = colors.gold, bold = true }) -- Gold text on selection bg
set("IncSearch", { bg = colors.rose, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.iris, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.line_bg, fg = colors.iris, bold = true }) -- Iris text on selection
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.rose }) -- Numbers are Rose
set("Boolean", { fg = colors.rose }) -- Booleans often match Numbers/Constants
set("Float", { fg = colors.rose })

set("Identifier", { fg = c.var })
set("Function", { fg = c.func })
set("Statement", { fg = c.keyword })
set("Conditional", { fg = c.keyword })
set("Repeat", { fg = c.keyword })
set("Label", { fg = c.keyword })
set("Operator", { fg = c.keyword }) -- Operators often match Keywords in Rose Pine
set("Keyword", { fg = c.keyword, italic = true })
set("Exception", { fg = c.keyword })

set("PreProc", { fg = colors.iris })
set("Include", { fg = c.keyword })
set("Define", { fg = c.keyword })
set("Macro", { fg = c.func })
set("PreCondit", { fg = c.keyword })

set("Type", { fg = c.type })
set("StorageClass", { fg = c.type })
set("Structure", { fg = c.type })
set("Typedef", { fg = c.type })

set("Special", { fg = colors.foam }) -- Decorators/Tags are Foam
set("SpecialChar", { fg = colors.foam })
set("Tag", { fg = colors.foam }) -- Tags are Foam
set("Delimiter", { fg = c.fg })
set("Debug", { fg = colors.rose })

set("Underlined", { underline = true })
set("Bold", { bold = true })
set("Italic", { italic = true })
set("Ignore", { fg = c.fg_gutter })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.gold, bold = true })

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
set("DiffAdd", { bg = "#252f36" }) -- Foam-tinted background approx
set("DiffChange", { bg = "#332e35" }) -- Rose-tinted background approx
set("DiffDelete", { bg = "#36262d" }) -- Love-tinted background approx
set("DiffText", { bg = colors.iris, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.love, italic = true }) -- Self is Love/Italic
set("@variable.parameter", { fg = colors.subtle }) -- Parameters are Subtle (Grey)
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@function", { link = "Function" })
set("@function.builtin", { link = "Function" })
set("@function.macro", { link = "Macro" })
set("@constructor", { fg = c.type })
set("@keyword", { fg = c.keyword, italic = true })
set("@keyword.function", { fg = c.keyword })
set("@operator", { fg = c.keyword })
set("@punctuation", { fg = c.fg_gutter }) -- Punctuation often subtle
set("@punctuation.delimiter", { fg = c.fg_gutter })
set("@punctuation.bracket", { fg = c.fg_gutter })
set("@label", { fg = c.keyword })
set("@type", { link = "Type" })
set("@type.builtin", { fg = c.type })
set("@constant", { fg = colors.rose }) -- Constants are Rose
set("@constant.builtin", { fg = colors.rose })
set("@tag", { link = "Tag" })
set("@tag.attribute", { fg = colors.iris }) -- Attributes often Iris in Rose Pine
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.foam, bold = true })
set("TelescopePromptTitle", { bg = colors.iris, fg = colors.bg })
set("TelescopePreviewTitle", { bg = colors.gold, fg = colors.bg })
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
	Text = colors.gold,
	Method = colors.love,
	Function = colors.love,
	Constructor = colors.love,
	Field = colors.gold,
	Variable = colors.text,
	Class = colors.foam,
	Interface = colors.foam,
	Module = colors.love,
	Property = colors.gold,
	Unit = colors.rose,
	Value = colors.rose,
	Enum = colors.foam,
	Keyword = colors.iris,
	Snippet = colors.love,
	Color = colors.love,
	File = colors.foam,
	Reference = colors.love,
	Folder = colors.foam,
	EnumMember = colors.love,
	Constant = colors.rose,
	Struct = colors.foam,
	Event = colors.rose,
	Operator = colors.iris,
	TypeParameter = colors.gold,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.iris, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.iris, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.foam, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Rose Pine Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.iris, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.subtle },
	},
	insert = {
		a = { bg = colors.foam, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.subtle },
	},
	visual = {
		a = { bg = colors.love, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.subtle },
	},
	replace = {
		a = { bg = colors.gold, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.subtle },
	},
	command = {
		a = { bg = colors.rose, fg = colors.bg, gui = "bold" },
		b = { bg = colors.line_bg, fg = colors.fg },
		c = { bg = "NONE", fg = colors.subtle },
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
