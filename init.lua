require "options"
require "mappings"

vim.keymap.set('n', '<leader>o', ':update<cr> :source<cr>')

local function load_plugins(plugin_list)
	vim.pack.add(plugin_list)
  for _, plugin in ipairs(plugin_list) do
    if plugin.src then
    end
  end

  for _, plugin in ipairs(plugin_list) do
    if plugin.name and plugin.setup then
      local ok, err = pcall(function()
        require(plugin.name).setup(plugin.setup)
      end)
      if not ok then
        vim.notify("Error setting up " .. plugin.name .. ": " .. err, vim.log.levels.ERROR)
      end
    end
  end

  for _, plugin in ipairs(plugin_list) do
    if plugin.config then
      local ok, err = pcall(plugin.config)
      if not ok then
        vim.notify("Error in config for " .. (plugin.name or "unknown") .. ": " .. err, vim.log.levels.ERROR)
      end
    end
  end
end

load_plugins(require('plugins'))

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    header = '',
    scope = 'cursor',
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable({ "lua_ls", "ts_ls", "clangd", "pyright", "dartls", "html", "cssls", "gopls" }, capabilities)

vim.cmd("set completeopt=menu,menuone,noselect")
vim.cmd(":hi statusline guibg=NONE")
