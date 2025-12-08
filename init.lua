require "options"
require "mappings"

local function load_plugins(plugin_list)
	vim.pack.add(plugin_list)

  for _, plugin in ipairs(plugin_list) do
    if plugin.name and plugin.setup then
			require(plugin.name).setup(plugin.setup)
    end
  end

  for _, plugin in ipairs(plugin_list) do
    if plugin.config then
      plugin.config()
    end
  end
end

load_plugins(require('plugins'))
vim.cmd("set completeopt=menu,menuone,noselect")
vim.cmd(":hi statusline guibg=NONE")
vim.cmd("colorscheme vague")
