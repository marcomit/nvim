require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>")

map("v", "s", "S")
-- Wrap with char
-- map({ "v" }, "'", "c'<Esc>pa'<Esc>", { desc = "Wrap with ''" })
-- map({ "v" }, "(", "c(<Esc>pa)<Esc>", { desc = "Wrap with ()" })
-- map({ "v" }, '"', 'c"<Esc>pa"<Esc>', { desc = 'Wrap with ""' })
-- map({ "v" }, "[", "c[<Esc>pa]<Esc>", { desc = "Wrap with []" })
-- map({ "v" }, "{", "c{<Esc>pa}<Esc>", { desc = "Wrap with {}" })

-- Swap lines
map({ "n" }, "<A-Up>", ":m .-2<CR>==", { desc = "Swap the line down", noremap = true, silent = true })
map({ "n" }, "<A-Down>", ":m .+1<CR>==", { desc = "Swap the line down", noremap = true, silent = true })
map({ "v" }, "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Swap the line down", noremap = true, silent = true })
map({ "v" }, "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Swap the line up", noremap = true, silent = true })

-- Save the files in any mode
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "v" }, "w", "<cmd> w <cr>")

-- local dap = require("dap")
map("n", "<leader>db", require("dap").toggle_breakpoint, {})
map("n", "<leader>dt", require("dap").terminate, {})
map("n", "<leader>do", require("dapui").open, {})
map("n", "<leader>de", require("dapui").close, {})

map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

map("v", "<leader>rw", [["hy:%s/<C-r>h//gI<Left><Left><Left>]], { desc = "Replace selection" })
