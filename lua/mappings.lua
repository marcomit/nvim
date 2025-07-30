local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "<C-z>", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent
map("n", ";", ":")
map("n", "w", ":w<CR>")
map({ "n", "v" }, "<leader>q", ":quit<CR>")

map({ "n", "v" }, "-", "^")
map({ "n", "v" }, "=", "$")

map("n", "<leader>e", ":Oil<CR>", { desc = "File explorer" })

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end)

local function swap_lines()
	-- Swap lines
	local opts = { desc = "Swap the line", noremap = true, silent = true }
	map({ "n" }, "<A-Up>", ":m .-2<CR>==", opts)
	map({ "n" }, "<A-Down>", ":m .+1<CR>==", opts)
	map({ "v" }, "<A-Up>", ":m '<-2<CR>gv=gv", opts)
	map({ "v" }, "<A-Down>", ":m '>+1<CR>gv=gv", opts)
end


local function replace()
	map("n", "rw", [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { desc = "Replace word under cursor" })
	map("v", "rs", [["hy:%s/<C-r>h//gc<Left><Left><Left>]], { desc = "Replace selection" })
end

swap_lines()
replace()
