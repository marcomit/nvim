return {
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<C-c>"] = { "show" },
	},
	fuzzy = {
		implementation = "lua"
	},
	appearance = {
		use_nvim_cmp_as_default = true,
	},
	sources = {
		default = { 'lsp', 'path', 'buffer', 'omni' },
	},
	completion = {
		documentation = {
			auto_show = false,
			window = { border = 'none' },
		},
		menu = {
			border = 'none',
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } }
			}
		},
		ghost_text = { enabled = true, },
	},
	signature = {
		enable = true,
		window = { border = 'none' },
	},
}
