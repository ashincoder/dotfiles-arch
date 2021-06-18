require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
            e = true -- bindings for prefixed with g
        }
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = {gc = "Comments"},
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    -- triggers = "auto" -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specifiy a list manually
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local mappings = {
    ["/"] = "Comment",
    ["b"] = "Dashboard",
    ["e"] = "Explorer",
    ["f"] = "Find File",
    ["z"] = "True Zen",
    f = {
        name = "+Telescope",
        n = {"<cmd>DasboardNewFile<cr>", "New File"},
        b = {"<cmd>Telescope buffers<cr>", "Telescope Buffers"},
        f = {"<cmd>Telescope find_files<cr>", "Telescope Files"},
        h = {"<cmd>Telescope help_tags<cr>", "Telescope Help"},
        r = {"<cmd>Telescope oldfiles<cr>", "Telescope Recent"},
        p = {"<cmd>Telescope media_files<cr>", "Telescope Media files"},
        g = {"<cmd>Telescope live_grep<cr>", "Telescope Grep"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        m = {"<cmd>Telescope marks<cr>", "Bookmarks"},
  },
    z = {
        name = "+TrueZen",
        b = {"<cmd>TZBottom<cr>", "toggle status line"},
        t = {"<cmd>TZTop<cr>", "toggle tab bar"},
        n = {"<cmd>TZLeft<cr>", "toggle numbers"},
        a = {"<cmd>TZAtaraxis<cr>", "toggle zen"},
  }
}

local wk = require("which-key")
wk.register(mappings, opts)
