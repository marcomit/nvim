-- Simple centered ASCII logo startup screen
local function setup_centered_logo()
  -- Only show logo if no files were opened
  if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Get window dimensions for centering
    local win_height = vim.api.nvim_win_get_height(0)
    local win_width = vim.api.nvim_win_get_width(0)
    
    -- ASCII logo
        local logo = {
      "███╗   ███╗ █████╗ ██████╗  ██████╗ ██████╗ ",
      "████╗ ████║██╔══██╗██╔══██╗██╔════╝██╔═══██╗",
      "██╔████╔██║███████║██████╔╝██║     ██║   ██║",
      "██║╚██╔╝██║██╔══██║██╔══██╗██║     ██║   ██║",
      "██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╗╚██████╔╝",
      "╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ",
    }
    
    -- Find the longest line for horizontal centering
    local max_width = 0
    for _, line in ipairs(logo) do
      max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
    end
    
    -- Calculate centering
    local total_lines = #logo
    local vertical_padding = math.max(0, math.floor((win_height - total_lines) / 2))
    local horizontal_padding = math.max(0, math.floor((win_width - max_width) / 2))
    
    -- Create the final centered lines
    local lines = {}
    
    -- Add vertical padding at the top
    for _ = 1, vertical_padding do
      table.insert(lines, "")
    end
    
    -- Add horizontally centered logo
    for _, line in ipairs(logo) do
      local padding = horizontal_padding
      table.insert(lines, string.rep(" ", padding) .. line)
    end
    
    -- Add remaining vertical padding to fill the buffer
    local remaining_lines = win_height - #lines
    for _ = 1, remaining_lines do
      table.insert(lines, "")
    end
    
    -- Set buffer content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_current_buf(buf)
    
    -- Buffer options
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "dashboard"
    
    -- Set up highlighting
    local ns = vim.api.nvim_create_namespace("centered_logo")
    
    -- Logo highlighting - beautiful blue color
    for i = 1, #logo do
      local line_num = vertical_padding + i - 1
      if line_num < #lines then
        vim.api.nvim_buf_add_highlight(buf, ns, "Function", line_num, 0, -1)
      end
    end
    
    -- Center the cursor on the logo
    local center_line = vertical_padding + math.floor(#logo / 2)
    vim.api.nvim_win_set_cursor(0, {center_line + 1, horizontal_padding})
    
    -- Auto-close dashboard when opening a file
    vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
      buffer = buf,
      callback = function()
        if vim.bo[buf].filetype == "dashboard" then
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buf) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end)
        end
      end,
    })
  end
end

-- Set up the centered logo
vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup_centered_logo,
})

-- Optional: Set up nice colors for the logo
vim.cmd([[
  highlight Function guifg=#7aa2f7 ctermfg=75
]])

-- Optional: Hide statusline on dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.ruler = false
    vim.opt_local.showcmd = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "dashboard" then
      vim.opt.laststatus = 2
      vim.opt.ruler = true
      vim.opt.showcmd = true
    end
  end,
})
