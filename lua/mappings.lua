local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "<C-z>", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent
map("n", ";", ":")
map("n", "w", ":w<CR>")
map({ "n", "v" }, "<leader>q", ":quit<CR>")

map({ "n", "v" }, "-", "^")
map({ "n", "v" }, ",", "%")
map({ "n", "v" }, "=", "$")
map({ "n", "v" }, "s", "S", { desc = "Surround text", remap = true })

map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>r", "<cmd>set rnu!<CR>", { desc = "Toggle line number" })

local function indent()
  local keys = { "<", ">" }
  for _, key in ipairs(keys) do
    map("n", key, "v" .. key, {})
    map("v", key, key .. "gv", {})
  end
end

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end)

-- Lazygit
map('n', '<leader>gg', "<cmd>LazyGit<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fw", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
-- map('n', '<leader>ft', ":TelescopeToggleBorder<CR>")


-- Swap lines
local function swap_lines()
  local opts = { desc = "Swap the line", noremap = true, silent = true }
  map({ "n" }, "<A-Up>", ":m .-2<CR>==", opts)
  map({ "n" }, "<A-Down>", ":m .+1<CR>==", opts)
  map({ "v" }, "<A-Up>", ":m '<-2<CR>gv=gv", opts)
  map({ "v" }, "<A-Down>", ":m '>+1<CR>gv=gv", opts)
end


map("n", "rw", [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("v", "rs", [["hy:%s/<C-r>h//gc<Left><Left><Left>]], { desc = "Replace selection" })

local function surround()
  local surround_keys = { '"', "'", "(", "[", "{", "`" }
  for _, key in ipairs(surround_keys) do
    map("v", key, function()
      vim.api.nvim_feedkeys("S" .. key, "x", false)
      vim.api.nvim_feedkeys("vi" .. key, "n", false)
    end, { noremap = true, silent = true, desc = "Surround with " .. key })
  end
end

local function bufferline()
  map('n', "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
  map('n', "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })

  map('n', '<leader>x', '<cmd>bdelete<CR>')
end

swap_lines()
surround()
bufferline()
surround()
indent()
