#!/bin/sh

picom &
xwallpaper --zoom /usr/share/backgrounds/wallpapers/0023.jpg &
slstatus &
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/dunst &
emacs --daemon &
