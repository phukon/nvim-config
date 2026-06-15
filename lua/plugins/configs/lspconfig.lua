dofile(vim.g.base46_cache .. "lsp")
-- Diagnostic signs & config (replaces deprecated require "nvchad.lsp")
vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙",
      [vim.diagnostic.severity.INFO]  = "󰋼",
      [vim.diagnostic.severity.HINT]  = "󰌵",
      [vim.diagnostic.severity.WARN]  = "",
    },
  },
  underline = true,
  update_in_insert = false,
}

local M = {}
local utils = require "core.utils"

-- Global LspAttach handler (replaces per-server on_attach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("NvChadLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if not client then return end

    -- Don't disable formatting for null-ls (none-ls) — it's the formatter
    if client.name ~= "null-ls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    utils.load_mappings("lspconfig", { buffer = bufnr })

    -- clangd-specific: disable signature help before the check below
    if client.name == "clangd" then
      client.server_capabilities.signatureHelpProvider = false
      client.offset_encoding = "utf-16"
    end

    if client.server_capabilities.signatureHelpProvider then
      require("nvchad.signature").setup(client)
    end

    if not utils.load_config().ui.lsp_semantic_tokens and client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.lsp.config('lua_ls', {
  capabilities = M.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
vim.lsp.enable('lua_ls')

return M
