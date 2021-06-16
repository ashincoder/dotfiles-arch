import os
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"                             # My terminal of choice
myBrowser = "firefox"                             # My browser
myEditor = "emacsclient -c -a 'emacs'"

keys = [
         ### The essentials
         Key([mod], "Return",
             lazy.spawn(myTerm),
             desc='Launches My Terminal'
             ),
         Key([mod], "Tab",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod], "q",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "q",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         Key([mod], "w",
             lazy.spawn(myBrowser),
             desc='Launches My Browser'
             ),
         Key([mod], "e",
             lazy.spawn(myEditor),
             desc='Launches My Browser'
             ),
         Key([mod], "n",
             lazy.spawn("pcmanfm"),
             desc='Launches My File Manager'
             ),
         Key([], "Print",
             lazy.spawn("scrot"),
             desc='Screenshot'
             ),
         Key([mod], "d",
             lazy.spawn("dmenu_run -c -l 15 -i -nb '#11121D' -nf '#ffffff' -sb '#555a9e' -fn 'NotoSans-10' -bw 4"),
             desc='Launches dmenu'
             ),
             # Laptop keys
         Key(
         [], "XF86AudioMute",
         lazy.spawn("pulseaudio-ctl mute")
            ),
         Key(
         [], "XF86AudioLowerVolume",
         lazy.spawn("amixer -D pulse sset Master 2%-")
            ),
         Key(
         [], "XF86AudioRaiseVolume",
         lazy.spawn("amixer -D pulse sset Master 2%+")
            ),
         Key(
         [], "XF86MonBrightnessUp",
         lazy.spawn("xbacklight +4")
            ),
         Key(
         [], "XF86MonBrightnessDown",
         lazy.spawn("xbacklight -4")
            ),
         ### Window controls
         Key([mod], "j",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "k",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "j",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "k",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "h",
             lazy.layout.shrink(),
             lazy.layout.increase_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l",
             lazy.layout.grow(),
             lazy.layout.decrease_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "f",
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),
         ### Stack controls
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], "space",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
        ### Dmenu Scripts
        Key([mod, "shift"], "w",
             lazy.spawn(".local/bin/dm-wifi"),
             desc='A dmenu wifi menu'
             ),
        Key([mod], "m",
             lazy.spawn(".local/bin/dm-sounds"),
             desc='A dmenu wifi menu'
             ),
        Key([mod], "o",
             lazy.spawn(".local/bin/todo"),
             desc='A dmenu todo menu'
             ),
         Key([mod], "c",
             lazy.spawn(".local/bin/dm-confedit"),
             desc='A dmenu config menu'
             ),
         Key([mod], "r",
             lazy.spawn(".local/bin/dm-record"),
             desc='A dmenu recording menu'
             ),
          Key([mod], "x",
             lazy.spawn(".local/bin/dm-logout"),
             desc='A dmenu logout menu'
             ),
         Key([mod, "shift"], "p",
             lazy.spawn("passmenu"),
             desc='A dmenu pass menu'
             ),
         Key([mod], "b",
             lazy.spawn(".local/bin/dm-bookman"),
             desc='A dmenu browser'
             ),
         Key([mod], "p",
             lazy.spawn(".local/bin/dm-kill"),
             desc='A dmenu kill menu'
             ),
]

group_names = [("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'}),
               ("", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    #layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2),
    # layout.RatioTile(**layout_theme),
    # layout.TreeTab(
    #      font = "Ubuntu",
    #      fontsize = 10,
    #      sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
    #      section_fontsize = 10,
    #      border_width = 2,
    #      bg_color = "1c1f24",
    #      active_bg = "c678dd",
    #      active_fg = "000000",
    #      inactive_bg = "a9a1e1",
    #      inactive_fg = "1c1f24",
    #      padding_left = 0,
    #      padding_x = 0,
    #      padding_y = 5,
    #      section_top = 10,
    #      section_bottom = 20,
    #      level_shift = 8,
    #      vspace = 3,
    #      panel_width = 200
    #      ),
    layout.Floating(**layout_theme)
]

colors = [["#11121D", "#000000"], # panel background
          ["#3d3f4b", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#74438f", "#74438f"], # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
          ["#A0A8CD", "#A0A8CD"], # window name
          ["#ecbbfb", "#ecbbfb"]] # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize = 12,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Image(
                       filename = "~/.config/qtile/icons/python-white.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.GroupBox(
                       font = "Ubuntu Bold",
                       fontsize = 19,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Prompt(
                       prompt = prompt,
                       font = "Ubuntu Mono",
                       padding = 10,
                       foreground = colors[3],
                       background = colors[1]
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 40,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.WindowName(
                       font = "FiraCode Nerd Font Bold",
                       fontsize = 14,
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 11,
                       foreground = colors[0],
                       background = colors[0]
                       ),
             widget.TextBox(text='\uE0B2',
                   background=colors[0],
                   fontsize=20,
                   padding=0,
                   foreground=colors[6]
                       ),
              widget.TextBox(
                       text = " ",
                       background = colors[6],
                       foreground = colors[0],
                       padding = 0,
                       fontsize = 16
                       ),
              widget.CPU(
                       font = "FiraCode Nerd Font Bold",
                       background = colors[6],
                       foreground = colors[0],
                       padding = 5,
                       threshold = 90,
                       format = "{load_percent}%"
                       ),
              widget.TextBox(
                       text = "\uE0B2",
                       foreground = '58e858',
                       background = colors[6],
                       padding = 0,
                       fontsize = 19
                       ),
              widget.TextBox(
                       text = " ",
                       background = '58e858',
                       foreground = colors[0],
                       padding = 0,
                       fontsize = 15
                       ),
              widget.ThermalSensor(
                       font = "FiraCode Nerd Font Bold",
                       background = '58e858',
                       foreground = colors[0],
                       threshold = 90,
                       padding = 5
                       ),
              widget.TextBox(
                       text = "\uE0B2",
                       foreground = 'd4667f',
                       background = '58e858',
                       padding = 0,
                       fontsize = 19
                       ),
              widget.TextBox(
                       text = " ",
                       background = 'd4667f',
                       foreground = colors[0],
                       padding = 2,
                       fontsize = 19
                       ),
              widget.Memory(
                       font = "FiraCode Nerd Font Bold",
                       background = 'd4667f',
                       foreground = colors[0],
                       padding = 5
                       ),
              widget.TextBox(
                       text = "\uE0B2",
                       foreground = 'e3a724',
                       background = 'd4667f',
                       padding = 0,
                       fontsize = 19
                       ),
              widget.TextBox(
                      text = " ",
                       background = 'e3a724',
                       foreground = colors[0],
                       padding = 0,
                       fontsize = 13
                       ),
              widget.Volume(
                       font = "FiraCode Nerd Font Bold",
                       background = 'e3a724',
                       foreground = colors[0],
                       padding = 5
                       ),
              widget.TextBox(
                       text = "\uE0B2",
                       foreground = 'a83295',
                       background = 'eda724',
                       padding = 0,
                       fontsize = 19
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       background = 'a83295',
                       foreground = colors[0],
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       font = "FiraCode Nerd Font Bold",
                       background = 'a83295',
                       foreground = colors[0],
                       padding = 5
                       ),
              widget.TextBox(
                       text = "\uE0B2",
                       foreground = '2ea38e',
                       background = 'a83295' ,
                       padding = 0,
                       fontsize = 19
                       ),
              widget.TextBox(
                       font = "FiraCode Nerd Font Bold",
                       text = "  ",
                       foreground = colors[0],
                       background = '2ea38e',
                       padding = 0,
                       # fontsize = 19
                       ),
              widget.Clock(
                       font = "FiraCode Nerd Font Bold",
                       background = '2ea38e',
                       foreground = colors[0],
                       format = "%A, %B %d - %H:%M "
                       ),
              ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[7:8]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                 # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.9, size=23))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Yad'),        # qalculate-gtk
    Match(wm_class='Xsane'),       # kdenlive
    Match(wm_class='Pavucontrol'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
