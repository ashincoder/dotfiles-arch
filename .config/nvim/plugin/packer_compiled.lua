-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ashin/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/ashin/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/ashin/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/ashin/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ashin/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  LuaSnip = {
    after = { "cmp_luasnip" },
    config = { "\27LJ\1\2F\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\fluasnip\27modules.configs.others\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    wants = { "friendly-snippets" }
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\26modules.configs.alpha\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/alpha-nvim"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\1\2L\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\ftimeout\3d\nsetup\18better_escape\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/better-escape.nvim"
  },
  ["cmp-buffer"] = {
    after = { "friendly-snippets", "cmp-path" },
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["cmp-nvim-lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after = { "cmp-buffer" },
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      cmp_luasnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["cmp-buffer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  cmp_luasnip = {
    after = { "cmp-nvim-lua" },
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      LuaSnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/cmp_luasnip"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  ["friendly-snippets"] = {
    load_after = {
      ["cmp-buffer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0028\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\29modules.configs.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\1\2H\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14signature\27modules.configs.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2I\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vconfig\31modules.configs.statusline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  neogen = {
    config = { "\27LJ\1\2D\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\fenabled\2\nsetup\vneogen\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/neogen"
  },
  neogit = {
    commands = { "Neogit" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["null-ls.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2H\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14autopairs\27modules.configs.others\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs", "LuaSnip" },
    config = { "\27LJ\1\0023\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\24modules.configs.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\2H\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14colorizer\27modules.configs.others\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    after = { "cmp-nvim-lsp", "null-ls.nvim" },
    load_after = {
      ["nvim-lspinstall"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    after = { "nvim-lspconfig" },
    config = { "\27LJ\1\0028\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\15lspinstall\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-lspinstall"
  },
  ["nvim-reload"] = {
    commands = { "Restart" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-reload"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFocus" },
    config = { "\27LJ\1\0028\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\29modules.configs.nvimtree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2:\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\31modules.configs.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons"
  },
  ["org-bullets.nvim"] = {
    config = { "\27LJ\1\0029\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\16org-bullets\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/org-bullets.nvim"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\forgmode\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["tabline.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\ftabline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/tabline.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30modules.configs.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm" },
    config = { "\27LJ\1\0028\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\29modules.configs.terminal\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim"
  },
  ["tokyodark.nvim"] = {
    loaded = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/start/tokyodark.nvim"
  },
  ["vim-matchup"] = {
    after_files = { "/home/ashin/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ashin/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp",
  ["^gitsigns"] = "gitsigns.nvim",
  ["^lsp_signature"] = "lsp_signature.nvim",
  ["^neogen"] = "neogen",
  ["^neogit"] = "neogit",
  ["^plenary"] = "plenary.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\1\2?\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\14telescope\18core.mappings\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: neogit
time([[Setup for neogit]], true)
try_loadstring("\27LJ\1\2<\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vneogit\18core.mappings\frequire\0", "setup", "neogit")
time([[Setup for neogit]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2>\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\rnvimtree\18core.mappings\frequire\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: toggleterm.nvim
time([[Setup for toggleterm.nvim]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\tterm\18core.mappings\frequire\0", "setup", "toggleterm.nvim")
time([[Setup for toggleterm.nvim]], false)
-- Setup for: nvim-web-devicons
time([[Setup for nvim-web-devicons]], true)
try_loadstring("\27LJ\1\2R\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\22nvim-web-devicons\14lazy_load\15core.utils\frequire\0", "setup", "nvim-web-devicons")
time([[Setup for nvim-web-devicons]], false)
time([[packadd for nvim-web-devicons]], true)
vim.cmd [[packadd nvim-web-devicons]]
time([[packadd for nvim-web-devicons]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2N\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\18gitsigns.nvim\14lazy_load\15core.utils\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\1\2=\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\fcomment\18core.mappings\frequire\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
time([[packadd for Comment.nvim]], true)
vim.cmd [[packadd Comment.nvim]]
time([[packadd for Comment.nvim]], false)
-- Setup for: packer.nvim
time([[Setup for packer.nvim]], true)
try_loadstring("\27LJ\1\2<\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vpacker\18core.mappings\frequire\0", "setup", "packer.nvim")
time([[Setup for packer.nvim]], false)
time([[packadd for packer.nvim]], true)
vim.cmd [[packadd packer.nvim]]
time([[packadd for packer.nvim]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\1\2L\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\16vim-matchup\14lazy_load\15core.utils\frequire\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Setup for: better-escape.nvim
time([[Setup for better-escape.nvim]], true)
try_loadstring("\27LJ\1\2S\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\23better-escape.nvim\14lazy_load\15core.utils\frequire\0", "setup", "better-escape.nvim")
time([[Setup for better-escape.nvim]], false)
time([[packadd for better-escape.nvim]], true)
vim.cmd [[packadd better-escape.nvim]]
time([[packadd for better-escape.nvim]], false)
-- Setup for: nvim-lspinstall
time([[Setup for nvim-lspinstall]], true)
try_loadstring("\27LJ\1\2P\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\20nvim-lspinstall\14lazy_load\15core.utils\frequire\0", "setup", "nvim-lspinstall")
time([[Setup for nvim-lspinstall]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: better-escape.nvim
time([[Config for better-escape.nvim]], true)
try_loadstring("\27LJ\1\2L\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\ftimeout\3d\nsetup\18better_escape\frequire\0", "config", "better-escape.nvim")
time([[Config for better-escape.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeFocus lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeFocus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Restart lua require("packer.load")({'nvim-reload'}, { cmd = "Restart", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeRefresh lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTerm lua require("packer.load")({'toggleterm.nvim'}, { cmd = "ToggleTerm", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType org ++once lua require("packer.load")({'orgmode.nvim', 'org-bullets.nvim'}, { ft = "org" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'tabline.nvim', 'lualine.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'alpha-nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]], true)
vim.cmd [[source /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]]
time([[Sourcing ftdetect script at: /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]], false)
time([[Sourcing ftdetect script at: /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]], true)
vim.cmd [[source /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]]
time([[Sourcing ftdetect script at: /home/ashin/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
