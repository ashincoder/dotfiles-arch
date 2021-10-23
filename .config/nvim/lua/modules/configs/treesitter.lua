local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      "bash",
      "css",
      "html",
      "javascript",
      "typescript",
      "python",
      "c",
      "go",
      "comment",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
   },
   autopairs = { enable = true },
}
