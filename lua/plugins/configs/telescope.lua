local Layout = require("nui.layout")
local Popup = require("nui.popup")
local telescope = require("telescope")
local TSLayout = require("telescope.pickers.layout")

-- Toggle border on/off
local USE_BORDER = true

vim.api.nvim_create_user_command("TelescopeToggleBorder", function()
  USE_BORDER = not USE_BORDER
  print("Telescope borders: " .. (USE_BORDER and "enabled" or "disabled"))
end, {})

local function make_popup(opts)
  if not USE_BORDER then opts.border = "none" end
  local popup = Popup(opts)
  function popup.border:change_title(title)
    popup.border.set_text(popup.border, "top", title)
  end

  return TSLayout.Window(popup)
end

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    layout_config = {
      vertical = { size = { width = "50%", height = "30%" } },
      horizontal = { size = { width = "90%", height = "80%" } },
    },
    previewer = true, -- Enable previewer by default
    create_layout = function(picker)
      local results = make_popup({
        focusable = false,
        border = {
          style = "single",
          text = { top = picker.results_title, top_align = "center" },
        },
        win_options = { winhighlight = "Normal:Normal" },
      })

      local prompt = make_popup({
        enter = true,
        border = {
          style = "single",
          text = { top = picker.prompt_title, top_align = "center" },
        },
        win_options = { winhighlight = "Normal:Normal" },
      })

      local preview = nil
      local layout_boxes = {}

      -- Create preview pane if previewer is enabled
      if picker.previewer then
        preview = make_popup({
          focusable = false,
          border = {
            style = "single",
            text = { top = "Preview", top_align = "center" },
          },
          win_options = { winhighlight = "Normal:Normal" },
        })

        -- Horizontal layout: prompt on top, results and preview side by side
        layout_boxes = {
          Layout.Box(prompt, { size = 3 }),
          Layout.Box({
            Layout.Box(results, { size = "50%" }),
            Layout.Box(preview, { size = "50%" }),
          }, { dir = "row", grow = 1 })
        }
      else
        -- Vertical layout without preview (original behavior)
        layout_boxes = {
          Layout.Box(prompt, { size = 3 }),
          Layout.Box(results, { grow = 1 }),
        }
      end

      local layout = Layout({
        relative = "editor",
        position = "50%",
        size = picker.previewer and picker.layout_config.horizontal.size or picker.layout_config.vertical.size,
      }, Layout.Box(layout_boxes, { dir = "col" }))

      layout.picker = picker
      layout.results = results
      layout.prompt = prompt
      layout.preview = preview

      return TSLayout(layout)
    end,
  },
  pickers = {
    find_files = {
      previewer = false, -- Enable preview for find_files
      layout_strategy = "flex",
    },
    live_grep = {
      previewer = true,
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          width = 0.9,
          height = 0.6,
        },
      },
    },
    -- Example of a picker without preview
    buffers = {
      previewer = false,
      layout_strategy = "flex",
    },
  }
})
