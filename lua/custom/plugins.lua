local plugins ={
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed ={
        "gopls",
        "eslint-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
      }
    }
  },
  {
    "mfussenegger/nvim-dap",
    init = function ()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap-go")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
      "olexsmir/gopher.nvim",
      ft = "go",
      config = function(_, opts)
        require("gopher").setup(opts)
        require("core.utils").load_mappings("gopher")
      end,
      build = function()
        vim.cmd [[silent! GoInstallDeps]]
      end,
  },
}

return plugins
