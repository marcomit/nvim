return {
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		setup = require('plugins.telescope'),
		opts = function() 
			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>ff', builtin.find_files)
			vim.keymap.set('n', '<leader>fw', builtin.live_grep)
			vim.keymap.set('n', '<leader>fb', builtin.buffers)
		end
	},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }
}
