require "options"
require "mappings"

vim.keymap.set('n', '<leader>o', ':update<cr> :source<cr>')

vim.pack.add({
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }
})

require('vscode').setup({
	transparent = true
})
require('oil').setup({})
require('nvim-autopairs').setup({})
require('bufferline').setup(require('plugins.bufferline'))
require('nvim-treesitter').setup({
	ensure_installed = { "lua", "vim", "typescript", "javascript", "dart" }
})

local telescope = require('telescope')
-- telescope.load_extension('fzf')
telescope.setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git/", "windows", "macos", "build", "linux", "ios", "android"},
  },
}

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    header = '',
    scope = 'cursor',
  },
})

require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vim", "vimdoc", "html", "css", "typescript", "javascript" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fw', builtin.live_grep)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

vim.lsp.config("*", { capabilities = capabilities })
local servers = { "html", "cssls", 'lua_ls', 'dartls', 'clangd', "ts_ls", "gopls" }

vim.lsp.enable(servers)

vim.lsp.enable({ "lua_ls", "ts_ls", "clangd", "pyright", "dartls" }, capabilities)
vim.cmd("set completeopt+=noselect")
vim.cmd("colorscheme vscode")
vim.cmd(":hi statusline guibg=NONE")
