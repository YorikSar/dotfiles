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
autoload -U select-word-style
zstyle ":zle:backward-kill-word" word-style bash

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt extended_glob
bindkey -v
export EDITOR=vim
export PAGER=less
export PATH="$HOME/.local/bin:$PATH"

case "$(uname -s)" in
    Linux)
        alias ll="ls -lah --color=auto"
        ;;
    FreeBSD)
        alias ll="ls -lAGh"
        ;;
esac


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


PS1="%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k"


if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
