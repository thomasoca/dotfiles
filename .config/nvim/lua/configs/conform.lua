require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "goimports", "gofmt" },
    css = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
  },

  format_after_save = {
    lsp_format = "fallback",
  },
  notify_when_error = true,
  log_level = vim.log.levels.DEBUG,
}
