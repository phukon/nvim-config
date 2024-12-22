local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local servers = {"tsserver", "tailwindcss", "eslint"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses ={
        unusedparams = true,
      }
    }
  }
})

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    client.offset_encoding = "utf-16"
    on_attach(client, bufnr)
  end,
  -- cmd = {
  --   "clangd",
  --   -- "--all-scopes-completion",
  --   -- "--suggest-missing-includes",
  --   -- "--background-index",
  --   -- "--pch-storage=disk",
  --   -- "--cross-file-rename",
  --   -- "--log=info",
  --   -- "--completion-style=detailed",
  --   -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  --   -- "--clang-tidy",
  --   "--offset-encoding=utf-16",
  --   -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  --   -- "--fallback-style=Google",
  --   -- "--header-insertion=never",
  --   -- "--query-driver=<list-of-white-listed-complers>"
  -- },
  capabilities = capabilities
}













