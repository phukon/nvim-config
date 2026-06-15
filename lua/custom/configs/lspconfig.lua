local base = require("plugins.configs.lspconfig")
local capabilities = base.capabilities

-- Simple servers with default settings
local servers = { "ts_ls", "tailwindcss", "eslint" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- gopls
vim.lsp.config('gopls', {
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
vim.lsp.enable('gopls')

-- clangd (on_attach overrides handled in LspAttach autocmd in plugins/configs/lspconfig.lua)
vim.lsp.config('clangd', {
  capabilities = capabilities,
})
vim.lsp.enable('clangd')
