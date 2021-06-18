-- Syntax on
vim.cmd "syntax on"

local g = vim.g

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

opt("o", "hidden", true)
opt("o", "ignorecase", true) -- Horizontal splits will automatically be below
opt("o", "splitbelow", true)
opt("o", "splitright", true) -- Vertical splits will automatically be to the right
opt("o", "termguicolors", true) -- set term gui colors most terminals support this
opt("w", "cul", true)
opt("o", "fileencoding", "utf-8") -- The encoding written to file

opt("o", "mouse", "a") -- Enable mouse

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 2) -- more space for displaying messages

opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "clipboard", "unnamedplus") -- Copy paste between vim and everything else
opt("o", "timeoutlen", 500)

-- for indentline
opt("b", "smartindent", true)
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

-- Numbers
opt("w", "number", true) -- set numbered lines
opt("o", "numberwidth", 2)
opt("w", "relativenumber", true) -- set relative numbered lines

-- Set gui font
opt("o", "guifont", "JetBrains Mono Nerd Font:h11")

-- For faster startup
g.python_host_skip_check = 1

-- hide line numbers in terminal windows
vim.api.nvim_exec(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]],
    false
)

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
return M

