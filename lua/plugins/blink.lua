return {
	keymap = {
		-- preset = 'default',
		-- menu navigation
		-- ["<C-j>"] = { "select_next" },
		-- ["<C-k>"] = { "select_prev" },
		-- ["<Tab>"] = { "select_next", "fallback" },
		-- ["<S-Tab>"] = { "select_prev", "fallback" },

		-- confirm / abort
		["<CR>"] = { "accept", "fallback" },
		-- ["<C-e>"] = { "close" },
		-- trigger manually
		["<C-Space>"] = { "show" },

		-- scroll docs
		-- ["<C-d>"] = { "scroll_docs_down", "fallback" },
		-- ["<C-u>"] = { "scroll_docs_up", "fallback" },
	},
	fuzzy = {
		implementation = "lua"
	},

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  completion = {
    menu = {
      border = 'rounded',
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = 'rounded',
      },
    },
    ghost_text = {
      enabled = true,
    },
  },

  signature = {
    enabled = true,
    window = {
      border = 'rounded',
    },
  },
}
