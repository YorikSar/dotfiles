{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['nickel'] = ['nls']
    '';
    plugins = with pkgs.vimPlugins; [
      (vim-nickel.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "YorikSar";
          repo = "vim-nickel";
          rev = "36f486d2be3e70af42fcfed37b00e71138e6b866";
          hash = "sha256-wb8UNs0eF6939pjZWafDoFgRh/10rKorJFZtPbTkn/k=";
        };
      }))
    ];
  };
  home.packages = [
    inputs.nickel.packages.${pkgs.system}.lsp-nls
  ];
}
