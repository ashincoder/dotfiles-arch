local g = vim.g

-- Map Leader
g.mapleader = " "
g.auto_save = 0

-- load all config files
require "pluginList" -- Plugin List
require "misc-utils" -- Settings
require "mappings" -- Keybindings

-- colorscheme related stuff

require "highlights"
require "colorscheme"

-- Treesitter
require "treesitter-nvim"

-- local base16 = require "base16"
-- base16(base16.themes["onedark"], true)

-- Bars
require "top-bufferline"
require "statusline"

-- lsp stuff
require "nvim-lspconfig"
require "compe-completion"

-- Commenter
require('nvim_comment').setup()
require("colorizer").setup() -- colorizer
require("neoscroll").setup() -- smooth scroll

-- WhichKey and Dashboard
require "whichkey"
require "dashboard"

require "telescope-nvim"
require "nvimTree" -- file tree stuff
require "file-icons"

-- git signs , lsp symbols etc
require "gitsigns-nvim"
require("nvim-autopairs").setup()
require("lspkind").init()

require "zenmode"
