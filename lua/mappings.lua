local map = vim.keymap.set

map({ 'n', 'v' }, ';', ':')
map({ 'n', 'v' }, 'w', '<cmd>w<cr>')

map({ 'n', 'v' }, '<esc>', '<cmd>nohlsearch<cr>')
map({ 'n', 'v', 'o' }, '=', '$')
map({ 'n', 'v', 'o' }, '-', '^')
map({ 'n', 'v', 'o' }, ',', '%')

map('n', '<leader>e', '<cmd>Oil --float<cr>')

-- Comments
map('n', '<leader>/', 'gcc', { remap = true })
map('v', '<leader>/', 'gc', { remap = true })

map('n', '<leader>d', vim.diagnostic.open_float)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fw", ":Telescope live_grep<CR>")
map("n", "<leader>b", ":Telescope buffers<CR>")

-- Format file
map({ 'n', 'v' }, '<leader>fm', function()
	require('conform').format({ async = true, lsp_fallback = true })
end)

-- Indent
map('n', '<', 'v<')
map('n', '>', 'v>')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Swap lines
map({ "n" }, "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
map({ "n" }, "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
map({ "v" }, "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map({ "v" }, "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map({ "n" }, "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
map({ "n" }, "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
map({ "v" }, "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map({ "v" }, "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

map("n", "rw", [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("v", "rs", [["hy:%s/<C-r>h//gc<Left><Left><Left>]], { desc = "Replace selection" })

map('n', "<Tab>", "<cmd>bnext<CR>", { desc = "Next tab" })
map('n', "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev tab" })

map('n', '<leader>x', '<cmd>bdelete<CR>')

map('n', '<leader>lg', '<cmd>LazyGit<cr>')
