-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "doomchad",
	hl_override = {
		Keyword = { fg = "#ff007c" },
		Function = { fg = "#61afef" },
		Statement = { fg = "#c678dd" },
		Type = { fg = "#e5c07b" },
		Identifier = { fg = "#98c379" },
	},
}

M.nvdash = {
	load_on_startup = true,
	header = function()
		return {
			"███╗   ███╗ █████╗ ██████╗  ██████╗ ██████╗ ",
			"████╗ ████║██╔══██╗██╔══██╗██╔════╝██╔═══██╗",
			"██╔████╔██║███████║██████╔╝██║     ██║   ██║",
			"██║╚██╔╝██║██╔══██║██╔══██╗██║     ██║   ██║",
			"██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╗╚██████╔╝",
			"╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ",
		}
	end,
}
M.ui = {
	tabufline = {
		lazyload = false,
	},
	statusline = {
		separator_style = "arrow",
	},
}

return M
