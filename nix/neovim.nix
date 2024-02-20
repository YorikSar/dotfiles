{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./languageclient.nix
    ./vim-fugitive.nix
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./extraConfig.vim;
    plugins = with pkgs.vimPlugins; [
      vim-solarized8
      vim-nix
      vim-dispatch
      vim-obsession
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup({})
        '';
      }
      {
        plugin = nvim-treesitter.withPlugins (p: [p.vimdoc]);
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            auto_install = false,
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            };
          }
        '';
      }
    ];
  };
  programs.git.ignores = [
    "Session.vim" # generated by vim-obsession
  ];

  home.activation.neovim-background = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.local/state/nvim"
    if [ ! -e  "$HOME/.local/state/nvim/background.vim" ]; then
      $DRY_RUN_CMD echo "set background=dark" > "$HOME/.local/state/nvim/background.vim"
    fi
  '';
  services.dark-mode-notify.onSwitch = [
    ''
      if [ "$DARKMODE" -eq 0 ]; then
        theme=light
      else
        theme=dark
      fi
      echo "set background=$theme" > "$HOME/.local/state/nvim/background.vim"
      find "$TMPDIR/nvim."* -type s -name 'nvim.*' -exec ${lib.getExe pkgs.neovim-remote} --nostart --servername '{}' -c "set bg=$theme" \;
    ''
  ];
}
