local h = vim.api.nvim_set_hl

-- 1. FORCE DARK MODE (Cyberpunk is a Dark Theme)
vim.opt.background = "dark"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Cyberpunk vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#050510", -- editor.background
	fg = "#E0E0E0", -- editor.foreground (Text)

	-- UI Surfaces
	sidebar = "#0F1019", -- sideBar.background
	line_bg = "#0F1019", -- editor.lineHighlightBackground
	highlight = "#1D1F2D", -- list.activeSelectionBackground
	selection = "#1D1F2D", -- menu.selectionBackground
	border = "#1D1F2D", -- editorGroup.border
	gutter = "#707A8C", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#707A8C", -- COMMENT
	cyan = "#00F0FF", -- FUNCTION / MISC
	blue = "#00F0FF", -- Alias Cyan as the theme uses Cyan for "Blue" slots
	purple = "#FF0055", -- KEYWORD (Neon Pink/Red)
	orange = "#FCEE0A", -- NUMBER / CONSTANT (Neon Yellow)
	yellow = "#FCEE0A", -- TYPE / CLASS (Neon Yellow)
	green = "#39FF14", -- STRING (Neon Green)
	red = "#FF0055", -- ERROR / INVALID (Neon Pink)

	-- Diagnostics
	error = "#FF0055", --
	warn = "#FCEE0A", --
	info = "#00F0FF", --
	hint = "#00F0FF", --

	-- Git
	git_add = "#39FF14", --
	git_change = "#FCEE0A", --
	git_delete = "#FF0055", --
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
	string = colors.green,
	func = colors.cyan, -- Functions are Cyan in Cyberpunk
	keyword = colors.purple, -- Keywords are Pink (#FF0055)
	var = colors.fg, -- Variables are standard foreground (#E0E0E0)
	type = colors.yellow, -- Types are Yellow (#FCEE0A)

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
set("CursorLineNr", { fg = colors.cyan, bold = true })

set("Cursor", { fg = colors.bg, bg = colors.yellow }) -- Yellow cursor for high contrast
set("lCursor", { fg = colors.bg, bg = colors.yellow })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
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
set("Number", { fg = colors.orange })
set("Boolean", { fg = colors.orange })
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.var })
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
set("Tag", { fg = colors.purple }) -- Tags are Pink in Cyberpunk
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

-- Git (Dark backgrounds tinted with neon)
set("DiffAdd", { bg = "#081a08" }) -- Deep Greenish
set("DiffChange", { bg = "#1a1a08" }) -- Deep Yellowish
set("DiffDelete", { bg = "#1a0808" }) -- Deep Reddish
set("DiffText", { bg = colors.cyan, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var })
set("@variable.builtin", { fg = colors.purple })
set("@variable.parameter", { fg = c.var })
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
set("@tag.attribute", { fg = colors.yellow })
set("@tag.delimiter", { link = "Delimiter" })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.cyan, bold = true })
set("TelescopePromptTitle", { bg = colors.cyan, fg = colors.bg })
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
	Function = colors.cyan,
	Constructor = colors.cyan,
	Field = colors.green,
	Variable = colors.fg,
	Class = colors.yellow,
	Interface = colors.yellow,
	Module = colors.cyan,
	Property = colors.green,
	Unit = colors.orange,
	Value = colors.orange,
	Enum = colors.yellow,
	Keyword = colors.purple,
	Snippet = colors.red,
	Color = colors.red,
	File = colors.cyan,
	Reference = colors.red,
	Folder = colors.cyan,
	EnumMember = colors.red,
	Constant = colors.orange,
	Struct = colors.yellow,
	Event = colors.orange,
	Operator = colors.purple,
	TypeParameter = colors.green,
}

for kind, color in pairs(kinds) do
	set("CmpItemKind" .. kind, { fg = color, bg = "NONE" })
	set("CmpItemMenu" .. kind, { fg = color, bg = "NONE", italic = true })
end

set("FloatBorder", { fg = colors.cyan, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.cyan, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Cyberpunk Style)
-- =============================================================================

local lualine_theme = {
	normal = {
		a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
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
