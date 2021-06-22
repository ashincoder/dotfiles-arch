
### EXPORT
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export EDITOR="nvim"
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.local/share/history/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Enable colors and change prompt:
autoload -U colors && colors

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)		# Include hidden files.

# aliases
alias pacman='sudo pacman'
alias ls='exa --icons -l'
alias rsync='rsync -avh'
alias open='xdg-open'
alias cat='bat'
alias du='dust'
alias repo='cd ~/Repos/'
alias zconf='cd ~/.config/zsh'
alias record='ffmpeg -f x11grab -i :0.0 -f alsa -i hw:0 out.mkv'
alias config='/usr/bin/git --git-dir=/home/ashin/dotfiles/ --work-tree=/home/ashin'

## devour alias
alias zathura='devour zathura'
alias mpv='devour mpv'
alias sxiv='devour sxiv'

## git alias
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

## repo aliases
alias addpack='makepkg -cf ; mv *.pkg.tar.zst ~/Repos/ashin-repo/x86_64 ; cd ~/Repos/ashin-repo/x86_64 ; ./update.sh ; cd .. ; ./gitupdater.sh'

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# path
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

#plugin
# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# spaceship
# SPACESHIP_CHAR_SYMBOL=❯
# SPACESHIP_CHAR_SUFFIX=" "

# autoload -U promptinit; promptinit
# prompt spaceship

# starship prompt
eval "$(starship init zsh)"

#colorscript
colorscript random
