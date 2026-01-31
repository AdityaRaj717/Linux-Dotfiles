local h = vim.api.nvim_set_hl

-- 1. FORCE LIGHT MODE (Catppuccin Latte is a Light Theme)
vim.opt.background = "light"

-- Helper to set highlights with force
local function set(group, opts)
	opts.force = true
	h(0, group, opts)
end

-- =============================================================================
-- 2. PALETTE DEFINITION (Mapped from Catppuccin Latte vscode.json)
-- =============================================================================
local colors = {
	-- Base
	bg = "#EFF1F5", -- editor.background
	fg = "#4C4F69", -- editor.foreground (Text)

	-- UI Surfaces
	sidebar = "#E6E9EF", -- sideBar.background
	line_bg = "#E6E9EF", -- editor.lineHighlightBackground
	highlight = "#CCD0DA", -- list.activeSelectionBackground
	selection = "#CCD0DA", -- menu.selectionBackground / selection approx
	border = "#CCD0DA", -- editorGroup.border
	gutter = "#9CA0B0", -- editorLineNumber.foreground

	-- Syntax (From tokenColors)
	comment = "#6C6F85", -- COMMENT
	cyan = "#179299", -- DECORATOR / TEAL
	blue = "#1E66F5", -- FUNCTION (Blue)
	purple = "#8839EF", -- KEYWORD (Mauve)
	orange = "#FE640B", -- NUMBER / CONSTANT (Orange)
	yellow = "#DF8E1D", -- ANNOTATION / CLASS (Yellow)
	green = "#40A02B", -- STRING (Green)
	red = "#D20F39", -- VARIABLE / TAG / ERROR (Red)
	pink = "#EA76CB", -- EXTRAS (Pink - Standard Latte approximation for contrast)
	teal = "#179299", -- MISC / DECORATOR

	-- Diagnostics
	error = "#D20F39", --
	warn = "#DF8E1D", --
	info = "#1E66F5", --
	hint = "#179299", -- Same as Cyan/Teal

	-- Git
	git_add = "#40A02B", --
	git_change = "#DF8E1D", --
	git_delete = "#D20F39", --
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
	func = colors.blue,
	keyword = colors.purple,
	var = colors.red, -- VSCode JSON maps "VARIABLE" to Red (#D20F39)
	type = colors.yellow, -- VSCode JSON maps "class" to Yellow (#DF8E1D)

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
set("CursorLineNr", { fg = colors.purple, bold = true })

-- VS Code uses Blue (#1E66F5) for the cursor in Light Mode
set("Cursor", { fg = colors.bg, bg = colors.blue })
set("lCursor", { fg = colors.bg, bg = colors.blue })
set("Visual", { bg = c.bg_selection })
set("VisualNOS", { bg = c.bg_selection })

set("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
set("IncSearch", { bg = colors.orange, fg = colors.bg })
set("CurSearch", { link = "IncSearch" })
set("MatchParen", { fg = colors.orange, bold = true, underline = true })

-- Menus (Pmenu)
set("Pmenu", { bg = "NONE", fg = c.fg })
set("PmenuSel", { bg = colors.highlight, fg = colors.blue, bold = true })
set("PmenuSbar", { bg = "NONE" })
set("PmenuThumb", { bg = c.fg_gutter })

-- Syntax
set("Comment", { fg = c.comment, italic = true })
set("String", { fg = c.string })
set("Character", { fg = c.string })
set("Number", { fg = colors.orange })
set("Boolean", { fg = colors.orange })
set("Float", { fg = colors.orange })

set("Identifier", { fg = c.var }) -- Variables are Red in Latte
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
set("Tag", { fg = colors.red })
set("Delimiter", { fg = colors.fg })
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

-- Git (Light Mode Diffs need pastel backgrounds)
set("DiffAdd", { bg = "#d0f5d0" }) -- Pastel Green
set("DiffChange", { bg = "#e8effc" }) -- Pastel Blue
set("DiffDelete", { bg = "#fce8e8" }) -- Pastel Red
set("DiffText", { bg = colors.blue, fg = colors.bg })
set("diffAdded", { fg = c.git.add })
set("diffRemoved", { fg = c.git.delete })
set("diffChanged", { fg = c.git.change })

-- Treesitter (Fine-tuned for VS Code Latte semantics)
set("@comment", { link = "Comment" })
set("@variable", { fg = c.var }) -- Red in Latte
set("@variable.builtin", { fg = colors.red })
set("@variable.parameter", { fg = colors.fg }) -- Parameters are text color in Latte JSON
set("@variable.member", { fg = colors.fg })
set("@property", { fg = colors.fg })
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
set("@tag", { fg = colors.red })
set("@tag.attribute", { fg = colors.yellow })
set("@tag.delimiter", { fg = colors.fg })

-- Plugins
set("NeoTreeDirectoryName", { fg = colors.blue, bold = true })
set("TelescopePromptTitle", { bg = colors.blue, fg = colors.bg })
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

set("FloatBorder", { fg = colors.blue, bg = "NONE" })
set("CmpItemAbbrMatch", { fg = colors.blue, bg = "NONE", bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = colors.cyan, bg = "NONE", bold = true })

-- =============================================================================
-- 5. LUALINE THEME (Catppuccin Latte Style)
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
