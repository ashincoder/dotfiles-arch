### My .bashrc ###

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
# Git completion
if [ -f /usr/share/bash-completion/git-completion.bash ]; then
  . /usr/share/bash-completion/git-completion.bash
fi

HISTFILE=$HOME/.local/share/history/bash_history

# Prompt
# define the color of the simple-bash-prompt
simple_bash_prompt_bracket_color="\033[1;32m"
simple_bash_prompt_command_color="\033[0;97m"
simple_bash_prompt_device_color="\033[1;34m"
simple_bash_prompt_dir_color="\033[1;37m"
simple_bash_prompt_git_branch_color="\033[1;33m"
simple_bash_prompt_git_color="\033[0;33m"
simple_bash_prompt_user_color="\033[1;36m"
simple_bash_prompt_separator_color="\033[1;37m"
simple_bash_prompt_symbol_color="\033[1;31m"
simple_bash_prompt_reset="\033[m"

# define the prompt terminator character
simple_bash_prompt_symbol="\\$"

# set the color with the exit status of the last command
simple_bash_prompt_exit_status_color () {
    if [ $1 -eq 0 ]; then
        echo -e "\033[0;32m"
    else
        echo -e "\033[0;31m"
    fi
}

# check if current directory is a git repo
simple_bash_prompt_is_git_repo () {
    git rev-parse 2> /dev/null
}

# print the git branch
simple_bash_prompt_get_git_branch () {
    simple_bash_prompt_git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ "$simple_bash_prompt_git_branch" = "HEAD" ]; then
        echo "no branch"
    else
        echo $simple_bash_prompt_git_branch
    fi
}

# define the simple-bash-prompt
simple_bash_prompt_build_prompt () {
simple_bash_prompt_exit_status=$?
simple_bash_prompt="\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]┬─\
\[$simple_bash_prompt_bracket_color\][\
\[$simple_bash_prompt_user_color\]\u\
\[$simple_bash_prompt_separator_color\]@\
\[$simple_bash_prompt_device_color\]\h\
\[$simple_bash_prompt_separator_color\]:\
\[$simple_bash_prompt_dir_color\]\w\
\[$simple_bash_prompt_bracket_color\]]\
\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]─\
\[$simple_bash_prompt_bracket_color\][\
\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]\t\
\[$simple_bash_prompt_bracket_color\]]"
if $(simple_bash_prompt_is_git_repo); then
    simple_bash_prompt+="\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]─"
    simple_bash_prompt+="\[$simple_bash_prompt_git_color\]["
    simple_bash_prompt+="\[$simple_bash_prompt_git_branch_color\]\$(simple_bash_prompt_get_git_branch)"
    simple_bash_prompt+="\[$simple_bash_prompt_git_color\]]"
fi
if [ "$TERM" = "linux" ]; then
    simple_bash_prompt+="\n\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]└─>"
    simple_bash_prompt+="\[$simple_bash_prompt_symbol_color\]$simple_bash_prompt_symbol \[$simple_bash_prompt_reset\]"
else
    simple_bash_prompt+="\n\[\$(simple_bash_prompt_exit_status_color $simple_bash_prompt_exit_status)\]╰─>"
    simple_bash_prompt+="\[$simple_bash_prompt_symbol_color\]$simple_bash_prompt_symbol \[$simple_bash_prompt_reset\]"
fi
PS1=$simple_bash_prompt
}
export PROMPT_COMMAND=simple_bash_prompt_build_prompt

#PS1='${arch_chroot:+($arch_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[33m\] ▸▹ \[\033[00m\]'
alias zathura='devour zathura'
alias sxiv='devour sxiv'
alias ls='exa -l --icons'
## dotfiles bar repository
alias config='/usr/bin/git --git-dir=/home/ashin/dotfiles/ --work-tree=/home/ashin'

fastfetch
