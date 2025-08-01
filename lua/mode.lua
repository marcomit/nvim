local map = vim.keymap.set
-- Method 1: Completely disable statusline globally
opt.laststatus = 0

-- Method 2: Hide statusline but keep it for splits
-- vim.opt.laststatus = 1  -- Only show when there are splits

-- Method 3: Conditional statusline hiding
local function toggle_statusline()
  if opt.laststatus:get() == 0 then
    opt.laststatus = 2
    print("Statusline enabled")
  else
    opt.laststatus = 0
    print("Statusline disabled")
  end
end

-- Keymap to toggle statusline on/off
map('n', '<leader>ts', toggle_statusline, { desc = "Toggle statusline" })

-- Method 4: Hide statusline for specific filetypes only
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dashboard", "alpha", "startify", "NvimTree", "neo-tree" },
  callback = function()
    vim.opt_local.laststatus = 0
  end,
})

-- Restore statusline when leaving these filetypes
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.filetype == "dashboard" or vim.bo.filetype == "alpha" then
      vim.opt.laststatus = 2 -- or whatever your preferred setting is
    end
  end,
})

-- Method 5: Hide statusline for floating windows
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local win_config = vim.api.nvim_win_get_config(0)
    if win_config.relative ~= "" then -- It's a floating window
      vim.opt_local.laststatus = 0
    else
      vim.opt.laststatus = 2 -- Normal window, show statusline
    end
  end,
})

-- Method 6: Minimal setup - hide everything for clean look
local function minimal_mode()
  -- Hide statusline
  vim.opt.laststatus = 0

  -- Hide command line when not in use
  vim.opt.cmdheight = 0

  -- Hide ruler
  vim.opt.ruler = false

  -- Hide mode indicator (-- INSERT --, etc.)
  vim.opt.showmode = false

  -- Hide command being typed
  vim.opt.showcmd = false

  print("Minimal mode enabled")
end

local function normal_mode()
  -- Restore statusline
  vim.opt.laststatus = 2

  -- Restore command line
  vim.opt.cmdheight = 1

  -- Restore ruler
  vim.opt.ruler = true

  -- Restore mode indicator
  vim.opt.showmode = true

  -- Restore command display
  vim.opt.showcmd = true

  print("Normal mode restored")
end

-- Keymaps for minimal mode toggle
vim.keymap.set('n', '<leader>tm', minimal_mode, { desc = "Enable minimal mode" })
vim.keymap.set('n', '<leader>tn', normal_mode, { desc = "Restore normal mode" })

-- Method 7: Per-buffer statusline control
local function hide_statusline_current_buffer()
  vim.wo.laststatus = 0
end

local function show_statusline_current_buffer()
  vim.wo.laststatus = 2
end

vim.keymap.set('n', '<leader>hs', hide_statusline_current_buffer, { desc = "Hide statusline (current buffer)" })
vim.keymap.set('n', '<leader>ss', show_statusline_current_buffer, { desc = "Show statusline (current buffer)" })

-- Method 8: Smart statusline - only show when needed
local function smart_statusline()
  -- Hide statusline by default
  vim.opt.laststatus = 0

  -- Show statusline temporarily when entering command mode
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
      vim.opt.laststatus = 2
    end,
  })

  -- Hide it again when leaving command mode
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
      vim.defer_fn(function()
        vim.opt.laststatus = 0
      end, 100) -- Small delay to see the result
    end,
  })
end

-- Enable smart statusline
-- smart_statusline()

-- Method 9: Zen mode - hide everything for distraction-free writing
local zen_mode_active = false

local function toggle_zen_mode()
  if zen_mode_active then
    -- Restore normal UI
    vim.opt.laststatus = 2
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes"
    vim.opt.foldcolumn = "0"
    vim.opt.colorcolumn = "80"
    vim.opt.cursorline = true

    -- Show bufferline if you have it
    vim.cmd("set showtabline=2")

    zen_mode_active = false
    print("Zen mode disabled")
  else
    -- Hide everything
    vim.opt.laststatus = 0
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "no"
    vim.opt.foldcolumn = "0"
    vim.opt.colorcolumn = ""
    vim.opt.cursorline = false

    -- Hide bufferline/tabline
    vim.cmd("set showtabline=0")

    zen_mode_active = true
    print("Zen mode enabled")
  end
end

vim.keymap.set('n', '<leader>z', toggle_zen_mode, { desc = "Toggle zen mode" })

-- Method 10: Context-aware statusline
local function setup_context_statusline()
  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = function()
      local buftype = vim.bo.buftype
      local filetype = vim.bo.filetype

      -- Hide statusline for special buffer types
      if buftype == "terminal" or
          buftype == "nofile" or
          filetype == "dashboard" or
          filetype == "alpha" or
          filetype == "NvimTree" then
        vim.opt_local.laststatus = 0
      else
        vim.opt.laststatus = 2
      end
    end,
  })
end

-- Enable context-aware statusline
-- setup_context_statusline()

-- Simple one-liner options (choose one):

-- Option A: Never show statusline
-- vim.opt.laststatus = 0

-- Option B: Only show statusline when there are multiple windows
-- vim.opt.laststatus = 1

-- Option C: Always show statusline (default)
-- vim.opt.laststatus = 2

-- Option D: Global statusline (Neovim 0.7+)
-- vim.opt.laststatus = 3
