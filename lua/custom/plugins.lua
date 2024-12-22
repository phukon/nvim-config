local logo = [[
██████╗ ██╗  ██╗██╗   ██╗██╗  ██╗ ██████╗ ███╗   ██╗
██╔══██╗██║  ██║██║   ██║██║ ██╔╝██╔═══██╗████╗  ██║
██████╔╝███████║██║   ██║█████╔╝ ██║   ██║██╔██╗ ██║
██╔═══╝ ██╔══██║██║   ██║██╔═██╗ ██║   ██║██║╚██╗██║
██║     ██║  ██║╚██████╔╝██║  ██╗╚██████╔╝██║ ╚████║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
]]                                     
logo = string.rep("\n", 4) .. logo .. "\n\n"

local plugins ={
  -- {
  --   "ErichDonGubler/lsp_lines.nvim",
  --   init = function ()
  --     require("lsp_lines").setup()
  --   end
  -- },
  -- {
  --   "ellisonleao/glow.nvim",
  --   config = function()
  --     require("glow").setup({
  --       glow_path = vim.fn.exepath("glow"), -- Explicitly tell plugin where to find glow
  --       install_path = "C:\\Users\\YourUsername\\scoop\\apps\\glow\\current\\glow.exe", -- Adjust this path based on your scoop installation
  --       border = "rounded",
  --       style = "dark",
  --       pager = false,
  --       width = 120,
  --     })
  --   end,
  --   cmd = "Glow"
  -- }
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("avante").setup({
  --       -- default configuration
  --       theme = "auto", -- "auto", "dark", or "light"
  --       transparent = false,
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = true },
  --         functions = {},
  --         variables = {},
  --       },
  --     })
  --   end,
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = logo,
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          {
            section = "terminal",
            cmd = "ascii-image-converter C:\\Users\\rikip\\Desktop\\EXIM\\pics\\profile\\anime-biker\\avatar.jpg -C -c",
            random = 10,
            pane = 2,
            indent = 4,
            height = 28
          },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>sd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>sh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    },
  },
  {
    "tikhomirov/vim-glsl",
    ft = "glsl",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      }
    }
  },
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
        "clangd",
        "codelldb",
        "clang-format",
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
    event = "VeryLazy",
    ft = {"go", "javascript", "typescript", "html", "json", "yaml"},
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
  {
    "NvChad/nvterm",
    opts = {
      terminals = {
        shell = "powershell.exe",
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.3,
            col = 0.25,
            width = 0.5,
            height = 0.4,
            border = "single",
          },
          horizontal = { location = "rightbelow", split_ratio = .3, },
          vertical = { location = "rightbelow", split_ratio = .5 },
        }
      }
    }
  },
}

return plugins
