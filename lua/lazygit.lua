local Popup = require("nui.popup")

-- Create a floating lazygit dialog using NUI
local function open_lazygit_nui()
  -- Get editor dimensions for responsive sizing
  local width = vim.api.nvim_get_option_value("columns", {})
  local height = vim.api.nvim_get_option_value("lines", {})

  -- Create the popup with NUI
  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Lazygit ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = math.floor(width * 0.9),
      height = math.floor(height * 0.9),
    },
    buf_options = {
      modifiable = true,
      readonly = false,
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  })

  -- Mount the popup
  popup:mount()

  -- Start lazygit in the terminal
  vim.fn.termopen("lazygit", {
    on_exit = function(_, exit_code)
      -- Close the popup when lazygit exits
      popup:unmount()

      -- Refresh all buffers to reflect git changes
      vim.schedule(function()
        vim.cmd("checktime")
      end)
    end,
  })

  -- Enter insert mode immediately
  vim.cmd("startinsert")

  -- Set up keymaps for the popup
  popup:map("n", "<Esc>", function()
    popup:unmount()
  end)

  popup:map("n", "q", function()
    popup:unmount()
  end)

  -- Terminal mode keymaps
  popup:map("t", "<C-\\><C-n>", "<C-\\><C-n>", { noremap = true })
  popup:map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
end

-- Alternative: Customizable NUI lazygit with different sizes
local function open_lazygit_nui_custom(size_preset)
  local presets = {
    small = { width = "60%", height = "70%" },
    medium = { width = "80%", height = "85%" },
    large = { width = "95%", height = "95%" },
    fullscreen = { width = "100%", height = "100%" }
  }

  local size = presets[size_preset] or presets.medium

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "double",
      text = {
        top = "󰊢 Lazygit",
        top_align = "center",
      },
    },
    position = "50%",
    size = size,
    buf_options = {
      modifiable = true,
      readonly = false,
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Keyword",
    },
  })

  popup:mount()

  -- Check if we're in a git repository
  local git_dir = vim.fn.finddir('.git', '.;')
  if git_dir == '' then
    -- Not in a git repo, show message and close
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, {
      "",
      "  Not in a git repository!",
      "",
      "  Navigate to a git repository and try again.",
      "",
      "  Press 'q' or <Esc> to close.",
      ""
    })

    popup:map("n", "q", function() popup:unmount() end)
    popup:map("n", "<Esc>", function() popup:unmount() end)
    return
  end

  vim.fn.termopen("lazygit", {
    on_exit = function()
      popup:unmount()
      vim.schedule(function()
        vim.cmd("checktime")
      end)
    end,
  })

  vim.cmd("startinsert")

  -- Set up keymaps
  popup:map("n", "<Esc>", function() popup:unmount() end)
  popup:map("n", "q", function() popup:unmount() end)
  popup:map("t", "<Esc>", "<C-\\><C-n>")
end

-- Advanced: NUI lazygit with loading state
local function open_lazygit_nui_advanced()
  -- Create loading popup first
  local loading_popup = Popup({
    enter = false,
    focusable = false,
    border = {
      style = "rounded",
      text = {
        top = " Loading... ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = 30,
      height = 5,
    },
  })

  loading_popup:mount()

  -- Set loading message
  vim.api.nvim_buf_set_lines(loading_popup.bufnr, 0, -1, false, {
    "",
    "  🔄 Starting Lazygit...",
    ""
  })

  -- Close loading popup after a short delay and open main popup
  vim.defer_fn(function()
    loading_popup:unmount()

    local main_popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
        text = {
          top = " 󰊢 Lazygit ",
          top_align = "center",
        },
      },
      position = "50%",
      size = {
        width = "85%",
        height = "90%",
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Function",
      },
    })

    main_popup:mount()

    vim.fn.termopen("lazygit", {
      on_exit = function()
        main_popup:unmount()
        vim.schedule(function()
          vim.cmd("checktime")
        end)
      end,
    })

    vim.cmd("startinsert")

    -- Keymaps
    main_popup:map("n", "<Esc>", function() main_popup:unmount() end)
    main_popup:map("n", "q", function() main_popup:unmount() end)
    main_popup:map("t", "<Esc>", "<C-\\><C-n>")
  end, 500)
end

-- NUI Lazygit with multiple git tools
local function open_git_tools_nui()
  local Menu = require("nui.menu")

  local menu_items = {
    Menu.item("Lazygit", { action = "lazygit" }),
    Menu.item("Git Status", { action = "git_status" }),
    Menu.item("Git Log", { action = "git_log" }),
    Menu.item("Git Diff", { action = "git_diff" }),
  }

  local menu = Menu({
    position = "50%",
    size = {
      width = 25,
      height = 8,
    },
    border = {
      style = "rounded",
      text = {
        top = " Git Tools ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Function",
    },
  }, {
    lines = menu_items,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      -- Menu closed
    end,
    on_submit = function(item)
      menu:unmount()

      local popup = Popup({
        enter = true,
        focusable = true,
        border = {
          style = "rounded",
          text = {
            top = " " .. item.text .. " ",
            top_align = "center",
          },
        },
        position = "50%",
        size = {
          width = "85%",
          height = "85%",
        },
      })

      popup:mount()

      local commands = {
        lazygit = "lazygit",
        git_status = "git status",
        git_log = "git log --oneline --graph -20",
        git_diff = "git diff --color=always"
      }

      vim.fn.termopen(commands[item.action], {
        on_exit = function()
          popup:unmount()
          if item.action == "lazygit" then
            vim.schedule(function()
              vim.cmd("checktime")
            end)
          end
        end,
      })

      if item.action == "lazygit" then
        vim.cmd("startinsert")
      end

      popup:map("n", "<Esc>", function() popup:unmount() end)
      popup:map("n", "q", function() popup:unmount() end)
      popup:map("t", "<Esc>", "<C-\\><C-n>")
    end,
  })

  menu:mount()
end

-- Auto-refresh when NUI popup closes
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*lazygit*",
  callback = function()
    vim.schedule(function()
      vim.cmd("checktime")
    end)
  end,
})
