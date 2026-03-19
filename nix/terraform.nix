{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    initLua = ''
      vim.lsp.enable('terraformls')
    '';
    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      hcl
      terraform
      hcl.associatedQuery
      terraform.associatedQuery
    ];
  };
  home.packages = with inputs.tf-nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
    terraform
    terraform-ls
  ];
}
