require "options"
require "mappings"

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = require "plugins"

require("lazy").setup(plugins, {})

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = false,
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

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.bo.filetype ~= "c" then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

vim.cmd "colorscheme vscode"

vim.cmd(":hi statusline guibg=NONE")

vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
