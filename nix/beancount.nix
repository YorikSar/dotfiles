{pkgs, ...}: let
  # Fix from PR https://github.com/NixOS/nixpkgs/pull/211520
  # Landed in upstream in https://github.com/beancount/fava/commit/b5a3b3e4a43e8cc1c55c31468554beabf43ae987
  favaPatched = pkgs.fava.overrideAttrs (old: {
    postPatch = ''
      substituteInPlace setup.cfg \
        --replace "cheroot>=8,<9" "cheroot>=8,<10"
    '';
  });
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-beancount
    ];
    treesitter.grammars = p: [p.beancount];
  };
  home.packages = with pkgs; [
    beancount
    favaPatched
  ];
}
