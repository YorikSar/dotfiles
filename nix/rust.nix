{ pkgs, ... }:
{
  programs.neovim = {
    initLua = ''
      vim.lsp.enable('rust_analyzer')
    '';
    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      rust
      rust.associatedQuery
    ];
  };
  home.packages = with pkgs; [
    rust-analyzer
  ];
}
