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
