require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.surround').setup({
	custom_surroundings = {
		['('] = { output = { left = '(', right = ')' } },
		['['] = { output = { left = '[', right = ']' } },
		['{'] = { output = { left = '{', right = '}' } },
		['<'] = { output = { left = '<', right = '>' } },
	},
})

local function load_logo(path)
	local file = io.open(vim.fn.expand(path), 'r')
	if not file then
		return ''
	end

	local content = file:read("*all")
	file:close()

	return content
end

local starter = require('mini.starter')

local logo = load_logo('~/.config/nvim/logo')
starter.setup({
	items = {
		{ name = '', action = '', section = '' },
	},
	content_hooks = {
		starter.gen_hook.aligning('center', 'center')
	},
	header = logo,
	footer = '',
	query_updaters = ''
})
