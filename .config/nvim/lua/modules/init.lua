return {
   {
      "wbthomason/packer.nvim",
      setup = function()
         require("core.mappings").packer()
      end,
   },

   -- TODO: Remove this when https://github.com/neovim/neovim/pull/15436 gets into upstream
   { "lewis6991/impatient.nvim" },

   -- NOTE: issue https://github.com/neovim/neovim/issues/12587 is still open
   { "antoinemadec/FixCursorHold.nvim" },

   -- NOTE: Faster alternative of filetype.vim
   { "nathom/filetype.nvim" },

   -- Colorscheme
   { "tiagovla/tokyodark.nvim" },

   -- Dashboard
   {
      "goolord/alpha-nvim",
      event = "VimEnter",
      config = function()
         require "modules.configs.alpha"
      end,
   },

   -- Tabline/Bufferline
   {
      "kdheepak/tabline.nvim",
      event = "BufWinEnter",
      config = function()
         require("tabline").setup()
      end,
   },

   -- StatusLine
   {
      "shadmansaleh/lualine.nvim",
      event = "BufWinEnter",
      config = function()
         require("modules.configs.statusline").config()
      end,
   },

   -- All important lua functions
   {
      "nvim-lua/plenary.nvim",
      module = "plenary",
   },

   -- More than a fuzzy finder
   {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
      },
      config = function()
         require "modules.configs.telescope"
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   },

   -- Snippets
   {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("modules.configs.others").luasnip()
      end,
   },

   {
      "rafamadriz/friendly-snippets",
      after = "cmp-buffer",
   },

   -- Completion
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      module = "cmp",
      config = function()
         require "modules.configs.cmp"
      end,
   },

   {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   },

   {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   },

   {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-lspconfig",
   },

   {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lua",
   },

   {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   },

   -- Autopairs
   {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         require("modules.configs.others").autopairs()
      end,
   },

   -- Icons
   {
      "kyazdani42/nvim-web-devicons",
      setup = function()
         require("core.utils").lazy_load "nvim-web-devicons"
      end,
   },

   -- Syntax parser and more
   {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      run = ":TSUpdate",
      event = "BufRead",
      config = function()
         require "modules.configs.treesitter"
      end,
   },

   -- Annotations generator
   {

      "danymat/neogen",
      module = "neogen",
      config = function()
         require("neogen").setup {
            enabled = true,
         }
      end,
   },

   -- Toggle Terminal
   {
      "akinsho/toggleterm.nvim",
      cmd = "ToggleTerm",
      config = function()
         require "modules.configs.terminal"
      end,
      setup = function()
         require("core.mappings").term()
      end,
   },

   -- Lsp installer
   {
      "kabouzeid/nvim-lspinstall",
      opt = true,
      config = function()
         require("lspinstall").setup()
      end,
      setup = function()
         require("core.utils").lazy_load "nvim-lspinstall"
      end,
   },

   -- Neovim Lsp
   {
      "neovim/nvim-lspconfig",
      after = "nvim-lspinstall",
      -- module = "lspconfig",
   },

   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
   },

   {
      "ray-x/lsp_signature.nvim",
      module = "lsp_signature",
      config = function()
         require("modules.configs.others").signature()
      end,
   },

   -- Orgmode
   {
      "kristijanhusak/orgmode.nvim",
      ft = { "org" },
      config = function()
         require("orgmode").setup()
      end,
      requires = {
         {
            "akinsho/org-bullets.nvim",
            ft = { "org" },
            config = function()
               require("org-bullets").setup()
            end,
         },
      },
   },

   -- Magit like neogit
   {
      "TimUntersberger/neogit",
      module = "neogit",
      cmd = "Neogit",
      setup = function()
         require("core.mappings").neogit()
      end,
   },

   -- Gitsigns and diffs
   {
      "lewis6991/gitsigns.nvim",
      module = "gitsigns",
      config = function()
         require "modules.configs.gitsigns"
      end,
      setup = function()
         require("core.utils").lazy_load "gitsigns.nvim"
      end,
   },

   -- HEX code colorizer
   {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
         require("modules.configs.others").colorizer()
      end,
   },

   -- Commenter
   {
      "numToStr/Comment.nvim",
      config = function()
         require("Comment").setup()
      end,
      setup = function()
         require("core.mappings").comment()
      end,
   },

   -- Match Parens
   {
      "andymass/vim-matchup",
      opt = true,
      setup = function()
         require("core.utils").lazy_load "vim-matchup"
      end,
   },

   -- Better Escaper
   {
      "max397574/better-escape.nvim",
      config = function()
         require("better_escape").setup {
            timeout = 100,
         }
      end,
      setup = function()
         require("core.utils").lazy_load "better-escape.nvim"
      end,
   },

   -- Nvim Tree
   {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFocus" },
      config = function()
         require "modules.configs.nvimtree"
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   },

   -- Reloader
   {
      "ashincoder/nvim-reload",
      cmd = "Restart",
   },
}
