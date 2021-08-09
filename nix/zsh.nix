{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    initExtraBeforeCompInit = "
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
    ";
    localVariables = {
      IPROMPT = "%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k";
      CPROMPT = "%B%F{green}%n@%m%k %B%F{blue}%1~ %S%#%s %b%f%k";
    };
    initExtra = ''
      setopt prompt_sp
      precmd () {
        PROMPT="$IPROMPT"
      }
      
      zle-keymap-select() {
        if [ "$KEYMAP" = "vicmd" ]; then
          PROMPT="$CPROMPT"
        else
          PROMPT="$IPROMPT"
        fi
        zle reset-prompt
      }
      zle -N zle-keymap-select
    '';
    shellAliases = {
      ll = "ls -laGh";
    };
    sessionVariables = {
      EDITOR = "vim";
      PAGER = "less";
      PATH = "$HOME/.local/bin:$PATH";
      NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
      TERMINFO = "${pkgs.ncurses5}/share/terminfo";
      LANG = "en_US.UTF-8";
    };
  };
}
