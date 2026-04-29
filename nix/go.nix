{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  programs.go = {
    enable = true;
    env.GOPATH = "${config.home.homeDirectory}/go";
  };
  programs.neovim = {
    initLua = ''
      vim.lsp.enable('gopls')
    '';
    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      go
      go.associatedQuery
    ];
  };
  home.packages = with pkgs; [
    gotools
    # gopls includes modernize binary that conflicts with gotools
    (lib.hiPrio gopls)
    (
      if !stdenv.isDarwin then
        golangci-lint
      else
        inputs.nixpkgs.legacyPackages.aarch64-darwin.golangci-lint
    )
    clang # looks like gopls needs this
  ];
}
