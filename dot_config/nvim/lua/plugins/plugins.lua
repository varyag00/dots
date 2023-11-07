local Util = require("lazyvim.util")

local M = {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  -- NOTE: not worth using since aerial extra was added
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   cmd = "SymbolsOutline",
  --   keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  --   config = true,
  -- },

  -- add more treesitter parsers (extend the default)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- magit
  --
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = {
      -- NOTE: decide kind={ tab, floating }
      { "<leader>gg", "<cmd>Neogit kind=tab<cr>", desc = "Magit Status" },
      {
        "n",
        "<leader>gs",
        function()
          Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
        end,
        { desc = "Lazygit (root dir)" },
      },
      {
        "n",
        "<leader>gG",
        function()
          Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
        end,
        { desc = "Lazygit (cwd)" },
      },
    },
    config = true,
    -- enabled = vim.g.vscode ~= nil,
    vscode = false,
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>wo", ":ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  -- it ain't elisp, but it's something. fennel seems interesting (compile lisp to lua): https://fennel-lang.org
  {
    "rafcamlet/nvim-luapad",
    keys = {
      { "<leader>cb", ":Luapad<cr>", desc = "Lua Scratch buffer" },
    },
    -- last release is pretty old
    version = false,
  },
  -- NOTE: choose either this + navic extra in lazy.lua, OR dropbar
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>c.", "<cmd>Navbuddy<cr>", desc = "Nav" },
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup({
        window = {
          border = "single",
        },
        lsp = { auto_attach = true },
      })
    end,
  },

  -- BUG: seems broken; perhaps must be loaded elsewhere?
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("telescope").load_extension("frecency")
  --   end,
  --   keys = {
  --     -- NOTE: decide kind={ tab, floating }
  --     { "<leader>f/", "<cmd>Telescope frecency<cr>", desc = "Telescope Frecency" },
  --   },
  -- },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        -- NOTE: needed for https://github.com/lukas-reineke/headlines.nvim/issues/41
        fat_headline_lower_string = "▔",
      },
    },
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml" },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
      },
    },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function(_, opts)
      local cfg = require("yaml-companion").setup(opts)
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension("yaml_schema")
    end,
  },
}

if vim.fn.has("nvim-0.10") == 1 then
  table.insert(
    M,
    -- NOTE: choose ONE of: dropbar, aerial.nvim (lvim extra), OR navbuddy + navic (lvim extra).
    {
      "Bekaboo/dropbar.nvim",
      -- optional, but required for fuzzy finder support
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
    }
  )
  --   vim.opt.foldmethod = "expr"
  --   vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  -- else
  --   vim.opt.foldmethod = "indent"
end

return M
