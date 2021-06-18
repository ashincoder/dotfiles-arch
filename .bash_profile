#
# ~/.bash_profile
#
[ -f /usr/share/bash-completion/bash-completion ] && . /usr/share/bash-completion/bash_completion

[[ -f ~/.bashrc ]] && . ~/.bashrc
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export MOZ_LEGACY_HOME="${XDG_CONFIG_HOME:-$HOME/.config/}mozilla"
export MOZ_PROFILE_HOME="${XDG_CONFIG_HOME:-$HOME/.config/}mozilla"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export LESSHISTFILE="-"

export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export XMONAD_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/xmonad"
export XMONAD_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache/}xmonad"
export XMONAD_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config/}xmonad"

export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export READER="xpdf"
export VIDEO="mpv"
export VISUAL="emacsclient -c -a emacs"
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export PAGER="bat"
