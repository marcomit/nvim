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
map('n', '<leader>lg', "<cmd>Lazygit<CR>")

-- Telescope
local function telescope()
  local cmd = ":Telescope "
  map("n", "<leader>ff", cmd .. "find_files<CR>")
  map("n", "<leader>fw", cmd .. "live_grep<CR>")
  map("n", "<leader>fb", cmd .. "buffers<CR>")
  map('n', '<leader>ft', ":TelescopeToggleBorder<CR>")
end

local function lazygit()
  -- Set up keymaps for different NUI lazygit functions
end

-- Swap lines
local function swap_lines()
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

local function surround()
  local surround_keys = { '"', "'", "(", "[", "{", "`" }
  for _, key in ipairs(surround_keys) do
    map("v", key, function()
      vim.api.nvim_feedkeys("S" .. key, "x", false)
      vim.api.nvim_feedkeys("vi" .. key, "n", false)
    end, { noremap = true, silent = true, desc = "Surround with " .. key })
  end
end



swap_lines()
replace()
surround()
telescope()
lazygit()
