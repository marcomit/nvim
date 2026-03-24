local o = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

o.number = false
o.relativenumber = false
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.swapfile = false
o.winborder = "rounded"
o.clipboard = 'unnamedplus'
o.termguicolors = true
o.undofile = true
o.completeopt = { "menu", "menuone", "noselect" }
o.shortmess:append("c")
o.showmode = false
o.showcmd = false
o.cmdheight = 0
o.cursorline = true
-- o.laststatus = 0
o.mouse = 'a'

-- Zinc language filetype detection
vim.filetype.add({
  extension = {
    zn = "zinc",
    zinc = "zinc",
  },
})
