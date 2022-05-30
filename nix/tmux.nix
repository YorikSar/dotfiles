{ config, pkgs, ... }:

let
  solarized = ''
    # default statusbar colors
    set-option -g status-style bg=black,fg=yellow
    
    # default window title colors
    set-window-option -g window-status-style fg=brightblue,bg=default
    
    # active window title colors
    set-window-option -g window-status-current-style fg=brightred,bg=default
    
    # pane border
    set-option -g pane-border-style fg=black
    set-option -g pane-active-border-style fg=brightgreen
    
    # message text
    set-option -g message-style bg=black,fg=brightred
    
    # pane number display
    set-option -g display-panes-active-colour blue #blue
    set-option -g display-panes-colour brightred #orange
    
    # clock
    set-window-option -g clock-mode-colour green #green
  '';
in
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 10000000;
    keyMode = "vi";
    terminal = "tmux-256color";
    secureSocket = false;
    extraConfig = solarized + ''
      set-option -g detach-on-destroy off

      set -ga terminal-overrides ",xterm-256color:Tc"
    '';
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15' # minutes
        '';
      }
    ];
  };
}
