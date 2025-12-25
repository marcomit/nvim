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

local plugins = require('plugins')

load_plugins(plugins)

vim.cmd("colorscheme vague")

vim.cmd(":hi statusline guibg=NONE")
