{
  pkgs,
  lib,
  ...
}: let
  LanguageClient-neovim-bin = pkgs.rustPlatform.buildRustPackage {
    pname = "LanguageClient-neovim-bin";
    inherit (LanguageClient-neovim) version src;

    cargoPatches = [
      ./languageclient-neovim.cargo.patch
    ];

    cargoHash = "sha256-43alR84MktYTmsKeUMm4gK8AjUIkGqcsuFeQPusBKD0=";
  };
  LanguageClient-neovim = pkgs.vimPlugins.LanguageClient-neovim.overrideAttrs (p: {
    propagatedBuildInputs = [LanguageClient-neovim-bin];
    preFixup = lib.replaceString (builtins.toString (lib.elemAt p.propagatedBuildInputs 0)) (builtins.toString LanguageClient-neovim-bin) (builtins.unsafeDiscardStringContext p.preFixup);
    meta = p.meta // { broken = false; };
  });
in {
  programs.neovim = {
    plugins = [
      LanguageClient-neovim
    ];
    extraConfig = lib.mkBefore ''
      let g:LanguageClient_serverCommands = {}
      let g:LanguageClient_rootMarkers = {}

      function LC_maps()
        if has_key(g:LanguageClient_serverCommands, &filetype)
          nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
          nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
          nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
          nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

          autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
          set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
        endif
      endfunction

      autocmd FileType * call LC_maps()
    '';
  };
}
