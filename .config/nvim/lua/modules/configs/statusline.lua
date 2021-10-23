-- Lsp status indicator
local function lsp_status()
   if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
   else
      return ""
   end
end

-- Treesitter status indicator
local function tree_status()
   local b = vim.api.nvim_get_current_buf()
   if next(vim.treesitter.highlighter.active[b]) then
      return " TREE"
   end
   return ""
end

-- Alpha Dashboard extension
local function alpha_statusline()
   return "Alpha"
end
local function description()
   return "Dashboard"
end
local empty = {
   function()
      return " "
   end,
   padding = 0,
}

local alpha_extension = {
   sections = {
      lualine_a = { alpha_statusline },
      lualine_c = { empty },
      lualine_y = { description },
   },
   filetypes = { "alpha" },
}

-- Setup
local M = {}

function M.config()
   local present, lualine = pcall(require, "lualine")
   if not present then
      return
   end

   lualine.setup {
      options = {
         theme = "auto",
         icons_enabled = true,
         -- component_separators = { left = "", right = "" },
         component_separators = { left = "", right = "" },
      },
      sections = {
         lualine_a = { "mode" },
         lualine_b = { "branch" },
         lualine_c = { "filename", "filetype" },
         lualine_x = {
            { "diagnostics", sources = { "nvim_lsp" } },
            -- { lsp_status, color = { fg = "#0d0c30", gui = "bold" } },
            -- { tree_status, color = { fg = "#004d01", gui = "bold" } },
            { lsp_status, color = { fg = "#37a3e6", gui = "bold" } },
            { tree_status, color = { fg = "#36e350", gui = "bold" } },
         },
         lualine_y = { "progress" },
      },
      extensions = { "nvim-tree", "quickfix", "toggleterm", alpha_extension },
   }
end

return M
