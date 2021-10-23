local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local html_path = vim.fn.stdpath "data" .. "/lspinstall/html"
local html_bin = html_path .. "/vscode-html/html-language-features/server/dist/node/htmlServerMain.js"

local M = {}

M.setup = function(on_attach, capabilities)
   lspconfig.html.setup {
      cmd = { html_bin, "--stdio" },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         html = {
            documentFormatting = false,
         },
      },
   }
end

return M
