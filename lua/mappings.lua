require("nvchad.mappings")

-- dd ([yours]) here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "v" }, "=", "$", { desc = "End of line" })

map({ "n", "v" }, ",", "[m", { desc = "", nowait = true })
map({ "n", "v" }, ".", "]m", { desc = "", nowait = true })
map("i", "\\\\", "<ESC>")

local function indent()
	local keys = { "<", ">" }
	for _, key in ipairs(keys) do
		map("n", key, "v" .. key, {})
		map("v", key, key .. "gv", {})
	end
end

local function surround()
	local keys = { "(", "[", "{" }
	local closing = { ")", "]", "}" }
	for i, key in ipairs(keys) do
		map("v", key, "S" .. key)
		map("v", closing[i], "S" .. closing[i])
	end
end

local function swap_lines()
	-- Swap lines
	local opts = { desc = "Swap the line", noremap = true, silent = true }
	map({ "n" }, "<A-Up>", ":m .-2<CR>==", opts)
	map({ "n" }, "<A-Down>", ":m .+1<CR>==", opts)
	map({ "v" }, "<A-Up>", ":m '<-2<CR>gv=gv", opts)
	map({ "v" }, "<A-Down>", ":m '>+1<CR>gv=gv", opts)
end

map({ "n", "v", "i" }, "<C-z>", "<Esc>u", { desc = "Prev" })
-- Save the files in any mode
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "v" }, "w", "<cmd> w <cr>")

local function debugger()
	local dap = require("dap")
	local dapui = require("dapui")
	map("n", "<leader>db", dap.toggle_breakpoint, {})
	map("n", "<leader>dt", dap.terminate, {})
	map("n", "<leader>do", dapui.open, {})
	map("n", "<leader>de", dapui.close, {})
end

local function replace()
	map("n", "rw", [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { desc = "Replace word under cursor" })
	map("v", "rs", [["hy:%s/<C-r>h//gc<Left><Left><Left>]], { desc = "Replace selection" })
end

map("v", "sn", function()
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg("v")
	vim.cmd("normal! gv")
	vim.fn.setreg("/", vim.fn.escape(selection, "\\/"))
	vim.cmd("normal! n")
end, { desc = "Search next word or selection" })

map("n", "sn", function()
	local word = vim.fn.expand("<cword>")
	vim.fn.setreg("/", vim.fn.escape(word, "\\/"))
	vim.cmd("normal! n")
end, { desc = "Search next word or selection" })

local function tmux()
	local cmd = vim.fn.system
	map({ "n", "v" }, "<leader>tc", function()
		cmd("tmux new-window")
	end)
	map({ "n", "v" }, "<leader>tv", function()
		cmd("tmux split -v")
	end)
	map({ "n", "v" }, "<leader>th", function()
		cmd("tmux split -h")
	end)
	map({ "n", "v" }, "<leader>tn", function()
		cmd("tmux next-window")
	end)
	map({ "n", "v" }, "<leader>tp", function()
		cmd("tmux prev-window")
	end)
	-- for i = 1, 9 do
	-- 	map({ "n", "v" }, "<leader>t" .. i, function()
	-- 		cmd("tmux select-window -t " .. i)
	-- 	end)
	-- end
end

debugger()
swap_lines()
replace()
surround()
indent()
tmux()
