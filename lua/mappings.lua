require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "v" }, "=", "$", { desc = "End of line" })
map({ "n", "v" }, "s", "S", { desc = "Surround text", remap = true })

map({ "n", "v" }, ",", "[m", { desc = "", nowait = true })
map({ "n", "v" }, ".", "]m", { desc = "", nowait = true })

map("n", "sv", function()
end, { desc = "" })

local function indent()
  local keys = { "<", ">" }
  for _, key in ipairs(keys) do
    map("n", key, "v" .. key, {})
    map("v", key, key .. "gv", {})
  end
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
  end, { desc = "Tmux create window" })

  map({ "n", "v" }, "<leader>tn", function()
    cmd("tmux next-window")
  end, { desc = "Tmux next window" })

  map({ "n", "v" }, "<leader>tp", function()
    cmd("tmux previous-window")
  end, { desc = "Tmux prev window" })

  map({ "n", "v", "i" }, "<C-J>", function()
    cmd("tmux split -v")
  end, { desc = "Tmux split vertical" })

  map({ "n", "v", "i" }, "<C-H>", function()
    cmd("tmux split -h")
  end, { desc = "Tmux split horizontal" })

  map({ "n", "v", "i" }, "<C-h>", function()
    cmd("tmux select-pane -L")
  end, { desc = "" })
  map({ "n", "v", "i" }, "<C-j>", function()
    cmd("tmux select-pane -D")
  end, { desc = "" })
  map({ "n", "v", "i" }, "<C-k>", function()
    cmd("tmux select-pane -U")
  end, { desc = "" })
  map({ "n", "v", "i" }, "<C-l>", function()
    cmd("tmux select-pane -R")
  end, { desc = "" })
end

debugger()
swap_lines()
replace()
surround()
indent()
tmux()
