# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate _prefix
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/yorik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install

case "$(uname -s)" in
    Linux)
        alias ll="ls -lah --color=auto"
        ;;
    FreeBSD)
        alias ll="ls -lAGh"
        ;;
esac
export PAGER=less

autoload -U select-word-style
zstyle ":zle:backward-kill-word" word-style bash

setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -ne "\ek$CMD\e\\"
    fi
}
precmd () {
    if [[ "$TERM" == "screen" ]]; then
        echo -ne "\ekzsh\e\\"
    fi    
}

export EDITOR=vim
set -o vi

PS1="%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k"

PATH="$HOME/.local/bin:$PATH"

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
