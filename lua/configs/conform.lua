local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    yaml = { "prettier" }
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    -- timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
