#!/bin/sh

slstatus &
picom &
xwallpaper --zoom /usr/share/backgrounds/wallpapers/0150.jpg &
/usr/bin/dunst &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &
emacs --daemon &
