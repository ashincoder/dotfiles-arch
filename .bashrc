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



times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.022  000.022: --- NVIM STARTING ---
000.605  000.583: locale set
001.174  000.569: inits 1
001.200  000.027: window checked
001.206  000.006: parsing arguments
001.280  000.074: expanding arguments
001.378  000.098: inits 2
002.286  000.908: init highlight
002.289  000.003: waiting for UI
004.097  001.808: done waiting for UI
004.137  000.039: initialized screen early for UI
004.557  000.046  000.046: sourcing /usr/share/nvim/archlinux.vim
004.572  000.128  000.082: sourcing /etc/xdg//nvim/sysinit.vim
017.893  000.411  000.411: sourcing /usr/share/nvim/runtime/syntax/syncolor.vim
018.461  001.057  000.646: sourcing /usr/share/nvim/runtime/syntax/synload.vim
028.841  000.027  000.027: sourcing /usr/share/vim/vimfiles/ftdetect/PKGBUILD.vim
029.292  000.019  000.019: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/gdscript.vim
029.335  000.018  000.018: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/gomod.vim
029.389  000.032  000.032: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/query.vim
030.230  011.702  011.607: sourcing /usr/share/nvim/runtime/filetype.vim
031.713  000.715  000.715: sourcing /usr/share/nvim/runtime/scripts.vim
032.201  014.884  001.410: sourcing /usr/share/nvim/runtime/syntax/syntax.vim
034.386  000.206  000.206: sourcing /usr/share/nvim/runtime/syntax/syncolor.vim
035.851  000.236  000.236: sourcing /usr/share/nvim/runtime/syntax/syncolor.vim
036.995  000.204  000.204: sourcing /usr/share/nvim/runtime/syntax/syncolor.vim
039.601  005.595  004.948: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim/colors/onedark.vim
166.376  161.741  141.262: sourcing /home/ashin/.config/nvim/init.lua
166.404  000.399: sourcing vimrc file(s)
166.542  000.082  000.082: sourcing /usr/share/nvim/runtime/ftplugin.vim
167.054  000.048  000.048: sourcing /usr/share/nvim/runtime/indent.vim
170.893  000.576  000.576: sourcing /home/ashin/.config/nvim/plugin/packer_compiled.vim
171.693  000.410  000.410: sourcing /usr/share/nvim/runtime/plugin/gzip.vim
171.740  000.017  000.017: sourcing /usr/share/nvim/runtime/plugin/health.vim
171.892  000.127  000.127: sourcing /usr/share/nvim/runtime/plugin/man.vim
172.939  000.355  000.355: sourcing /usr/share/nvim/runtime/pack/dist/opt/matchit/plugin/matchit.vim
173.083  001.164  000.809: sourcing /usr/share/nvim/runtime/plugin/matchit.vim
173.329  000.220  000.220: sourcing /usr/share/nvim/runtime/plugin/matchparen.vim
174.007  000.648  000.648: sourcing /usr/share/nvim/runtime/plugin/netrwPlugin.vim
174.297  000.017  000.017: sourcing /home/ashin/.local/share/nvim/rplugin.vim
174.310  000.233  000.217: sourcing /usr/share/nvim/runtime/plugin/rplugin.vim
174.490  000.152  000.152: sourcing /usr/share/nvim/runtime/plugin/shada.vim
174.572  000.038  000.038: sourcing /usr/share/nvim/runtime/plugin/spellfile.vim
174.828  000.219  000.219: sourcing /usr/share/nvim/runtime/plugin/tarPlugin.vim
174.999  000.125  000.125: sourcing /usr/share/nvim/runtime/plugin/tohtml.vim
175.064  000.030  000.030: sourcing /usr/share/nvim/runtime/plugin/tutor.vim
175.373  000.276  000.276: sourcing /usr/share/nvim/runtime/plugin/zipPlugin.vim
175.751  004.980: loading plugins
176.467  000.106  000.106: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/TrueZen.nvim/plugin/true-zen-cmds.vim
177.022  000.354  000.354: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/plugin/dashboard.vim
177.488  000.199  000.199: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/galaxyline.nvim/plugin/galaxyline.vim
178.102  000.027  000.027: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim/autoload/indent_blankline/helper.vim
180.805  003.053  003.026: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim/plugin/indent_blankline.vim
181.121  000.036  000.036: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/neoformat/plugin/neoformat.vim
181.491  000.030  000.030: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-autopairs/plugin/nvim-autopairs.vim
181.775  000.036  000.036: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua/plugin/bufferline.vim
182.005  000.049  000.049: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua/plugin/colorizer.vim
182.455  000.209  000.209: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-compe/plugin/compe.vim
182.767  000.120  000.120: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig/plugin/lspconfig.vim
183.042  000.071  000.071: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-lspinstall/plugin/lspinstall.vim
183.391  000.163  000.163: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua/plugin/tree.vim
184.617  001.027  001.027: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/plugin/nvim-treesitter.vim
184.824  000.022  000.022: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/gdscript.vim
184.876  000.019  000.019: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/gomod.vim
184.940  000.032  000.032: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-treesitter/ftdetect/query.vim
185.131  000.055  000.055: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons/plugin/nvim-web-devicons.vim
185.444  000.063  000.063: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/plenary.nvim/plugin/plenary.vim
185.708  000.021  000.021: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/startuptime.vim/plugin/startuptime.vim
186.554  000.605  000.605: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/telescope.nvim/plugin/telescope.vim
187.092  000.337  000.337: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-auto-save/plugin/AutoSave.vim
187.771  000.480  000.480: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-closetag/plugin/closetag.vim
190.671  002.686  002.686: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-devicons/plugin/webdevicons.vim
191.496  000.601  000.601: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/plugin/vsnip.vim
191.741  000.031  000.031: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/which-key.nvim/plugin/which-key.vim
191.975  005.817: loading packages
195.711  003.598  003.598: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/nvim-compe/after/plugin/compe.vim
196.083  000.510: loading after plugins
196.110  000.027: inits 3
199.130  003.020: reading ShaDa
200.267  000.037  000.037: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim/autoload/indent_blankline.vim
200.634  001.467: opening buffers
218.048  017.413: BufEnter autocommands
218.055  000.008: editing files in windows
218.691  000.198  000.198: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/autoload/dashboard.vim
219.147  000.044  000.044: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/autoload/dashboard/utils.vim
219.810  000.155  000.155: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/autoload/dashboard/section.vim
221.000  000.285  000.285: sourcing /usr/share/nvim/runtime/autoload/provider/clipboard.vim
221.974  000.173  000.173: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/syntax/dashboard.vim
222.504  000.019  000.019: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/dashboard-nvim/syntax/dashboard.vim
246.353  027.424: VimEnter autocommands
246.365  000.013: UIEnter autocommands
246.373  000.008: before starting main loop
247.626  000.361  000.361: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/vsnip.vim
247.988  000.107  000.107: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Position.vim
248.120  000.036  000.036: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip.vim
248.541  001.364  000.860: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vsnip/snippet.vim
248.963  000.230  000.230: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/LSP/TextEdit.vim
249.342  000.105  000.105: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Text.vim
249.885  000.204  000.204: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/Vim/Buffer.vim
250.283  000.094  000.094: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/Vim/Option.vim
250.861  000.231  000.231: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Diff.vim
251.179  004.085  001.857: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vsnip/session.vim
251.465  004.462  000.376: sourcing /home/ashin/.local/share/nvim/site/pack/packer/start/vim-vsnip/autoload/vsnip.vim
256.167  005.333: first screen update
256.173  000.006: --- NVIM STARTED ---
