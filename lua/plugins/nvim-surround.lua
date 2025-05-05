-- test
return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability
	event = "VeryLazy",
	config = function()
		local surround = require("nvim-surround")
		surround.setup({
			surrounds = {
				["("] = {
					add = function()
						return { { "(" }, { ")" } }
					end,
				},
				["{"] = {
					add = function()
						return { { "{" }, { "}" } }
					end,
				},
				["["] = {
					add = function()
						return { { "[" }, { "]" } }
					end,
				},
				["<"] = {
					add = function()
						return { { "<" }, { ">" } }
					end,
				},
			},
		})
	end,
}
