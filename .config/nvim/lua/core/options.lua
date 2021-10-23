local M = {}

-- disable some builtin vim plugins
function M.disabled_builtins()
   local disabled_built_ins = {
      "man",
      "2html_plugin",
      "gzip",
      "logipat",
      "matchit",
      "tar",
      "tarPlugin",
      "rrhelper",
      "spellfile_plugin",
      "vimball",
      "vimballPlugin",
      "zip",
      "zipPlugin",
      "getscript",
      "getscriptPlugin",
      "netrwSettings",
      "netrwFileHandlers",
      -- "netrw",
      -- "netrwPlugin",
   }
   for _, plugin in pairs(disabled_built_ins) do
      vim.g["loaded_" .. plugin] = 1
   end
   -- Do not source the default filetype.vim
   vim.g.did_load_filetypes = 1
end

M.load_options = function()
   M.disabled_builtins()
   local options = {
      termguicolors = true,
      background = "dark",
      clipboard = "unnamedplus",
      cmdheight = 1,
      cul = true, -- cursor line
      expandtab = true, -- Indentline
      shiftwidth = 2,
      smartindent = true,
      completeopt = "menuone,noselect",
      hidden = true,
      ignorecase = true,
      mouse = "a",
      spelllang = "en",
      scrolloff = 5,
      number = true, -- Numbers
      relativenumber = true,
      numberwidth = 2,
      ruler = true,
      signcolumn = "yes",
      splitbelow = true,
      splitright = true,
      tabstop = 8,
      timeoutlen = 300,
      undofile = true,
      updatetime = 250, -- interval for writing swap file to disk, also used by gitsigns
   }
   -- go to previous/next line with h,l,left arrow and right arrow
   -- when cursor reaches end/beginning of line
   vim.opt.whichwrap:append "<>hl"
   vim.opt.shortmess:append "sI"
   vim.opt.fillchars = { eob = " " }
   vim.opt.shortmess:append "c"

   for k, v in pairs(options) do
      vim.opt[k] = v
   end
   vim.g.tokyodark_transparent_background = true
   vim.g.colors_name = "tokyodark"
   -- vim.g.colors_name = "onedarker"
   vim.g.mapleader = " "
end

return M
