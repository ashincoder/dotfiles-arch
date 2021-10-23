local present, alpha = pcall(require, "alpha")
if not present then
   return
end

local header = {
   type = "text",
   val = {
      [[]],
      [[ MMMMMMMM               MMMMMMMM  iiii                     iiii VVVVVVVV           VVVVVVVV iiii                           ]],
      [[ M:::::::M             M:::::::M i::::i                   i::::iV::::::V           V::::::Vi::::i                          ]],
      [[ M::::::::M           M::::::::M  iiii                     iiii V::::::V           V::::::V iiii                           ]],
      [[ M:::::::::M         M:::::::::M                                V::::::V           V::::::V                                ]],
      [[ M::::::::::M       M::::::::::Miiiiiiinnnn  nnnnnnnn    iiiiiii V:::::V           V:::::Viiiiiii    mmmmmmm    mmmmmmm    ]],
      [[ M:::::::::::M     M:::::::::::Mi:::::in:::nn::::::::nn  i:::::i  V:::::V         V:::::V i:::::i  mm:::::::m  m:::::::mm  ]],
      [[ M:::::::M::::M   M::::M:::::::M i::::in::::::::::::::nn  i::::i   V:::::V       V:::::V   i::::i m::::::::::mm::::::::::m ]],
      [[ M::::::M M::::M M::::M M::::::M i::::inn:::::::::::::::n i::::i    V:::::V     V:::::V    i::::i m::::::::::::::::::::::m ]],
      [[ M::::::M  M::::M::::M  M::::::M i::::i  n:::::nnnn:::::n i::::i     V:::::V   V:::::V     i::::i m:::::mmm::::::mmm:::::m ]],
      [[ M::::::M   M:::::::M   M::::::M i::::i  n::::n    n::::n i::::i      V:::::V V:::::V      i::::i m::::m   m::::m   m::::m ]],
      [[ M::::::M    M:::::M    M::::::M i::::i  n::::n    n::::n i::::i       V:::::V:::::V       i::::i m::::m   m::::m   m::::m ]],
      [[ M::::::M     MMMMM     M::::::M i::::i  n::::n    n::::n i::::i        V:::::::::V        i::::i m::::m   m::::m   m::::m ]],
      [[ M::::::M               M::::::Mi::::::i n::::n    n::::ni::::::i        V:::::::V        i::::::im::::m   m::::m   m::::m ]],
      [[ M::::::M               M::::::Mi::::::i n::::n    n::::ni::::::i         V:::::V         i::::::im::::m   m::::m   m::::m ]],
      [[ M::::::M               M::::::Mi::::::i n::::n    n::::ni::::::i          V:::V          i::::::im::::m   m::::m   m::::m ]],
      [[ MMMMMMMM               MMMMMMMMiiiiiiii nnnnnn    nnnnnniiiiiiii           VVV           iiiiiiiimmmmmm   mmmmmm   mmmmmm ]],
      [[]],
   },
   opts = {
      position = "center",
      hl = "AlphaHeader",
   },
}

local handle = io.popen 'fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" '
local plugins = handle:read "*a"
handle:close()

local thingy = io.popen 'echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'
local date = thingy:read "*a"
thingy:close()

local plugin_count = {
   type = "text",
   val = "└─   " .. plugins .. " plugins in total ─┘",
   opts = {
      position = "center",
      hl = "AlphaHeader",
   },
}

local heading = {
   type = "text",
   val = "┌─   Today is " .. date .. " ─┐",
   opts = {
      position = "center",
      hl = "AlphaHeader",
   },
}

local footer = {
   type = "text",
   val = "-MiniVim-",
   opts = {
      position = "center",
      hl = "AlphaFooter",
   },
}

local function button(sc, txt, keybind)
   local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

   local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 24,
      align_shortcut = "right",
      hl_shortcut = "AlphaButtons",
      hl = "AlphaButtons",
   }
   if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
   end

   return {
      type = "button",
      val = txt,
      on_press = function()
         local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
         vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
   }
end

local buttons = {
   type = "group",
   val = {
      button("CTRL f", "   New", ":enew<CR>"),
      button("LDR ff", "   Files", ":Telescope find_files<CR>"),
      button("LDR fr", "   Recents", ":Telescope oldfiles<CR>"),
      button("LDR fb", "   Buffers", ":Telescope buffers<CR>"),
      button("LDR fw", "   Grep", ":Telescope live_grep<CR>"),
   },
   opts = {
      spacing = 1,
   },
}

local section = {
   header = header,
   buttons = buttons,
   plugin_count = plugin_count,
   heading = heading,
   footer = footer,
}

local opts = {
   layout = {
      { type = "padding", val = 3 },
      section.header,
      { type = "padding", val = 2 },
      section.heading,
      section.plugin_count,
      { type = "padding", val = 1 },
      -- section.top_bar,
      section.buttons,
      -- section.bot_bar,
      { type = "padding", val = 1 },
      section.footer,
   },
   opts = {
      margin = 5,
   },
}
alpha.setup(opts)
