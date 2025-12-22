return {
	-- Color scheme
	{
		src = "https://github.com/Mofiqul/vscode.nvim",
		name = 'vscode',
		setup = { }
	},
	{
		src = "https://github.com/vague-theme/vague.nvim",
		name = 'vague',
		setup = require('plugins.vague'),
	},
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		name = 'mini',
		config = function()
			require('plugins.mini')
		end
	},
	{
		src = "https://github.com/kdheepak/lazygit.nvim"
	},
	{
		src = "https://github.com/stevearc/oil.nvim",
		name = 'oil',
		setup = require('plugins.oil')
	},
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		config = function()
			require('plugins.lspconfig')
		end
	},
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		name = 'telescope',
		setup = {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"windows",
					"macos",
					"build",
					"linux",
					"ios",
					"android"
				},
			}
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files)
			vim.keymap.set('n', '<leader>fw', builtin.live_grep)
			vim.keymap.set('n', '<leader>fb', builtin.buffers)
		end
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		name = 'nvim-treesitter',
		setup = {
			ensure_installed = { "lua", "vim", "typescript", "javascript", "dart" }
		},
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = {
					"lua", "vim", "vimdoc",
					"html", "css",
					"typescript", "javascript"
				},
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				indent = { enable = true },
			}
		end
	},
	{
		src = "https://github.com/nvim-lua/plenary.nvim"
	},
	{
		src = "https://github.com/kylechui/nvim-surround",
		name = 'nvim-surround',
		setup = {}
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		name = 'blink.cmp',
		setup = require('plugins.blink')
	},
	{
		src = "https://github.com/stevearc/conform.nvim",
		name = "conform",
		setup = require('plugins.conform')
	}
}
