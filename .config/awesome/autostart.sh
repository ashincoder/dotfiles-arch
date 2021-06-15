#!/bin/bash

picom &
/usr/bin/dunst &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xwallpaper --zoom /usr/share/backgrounds/wallpapers/0152.jpg &
xsetroot -cursor_name left_ptr &
/usr/bin/emacs --daemon &
