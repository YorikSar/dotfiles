{ config, pkgs, ... }:

let

  vim-fugitive = pkgs.vimPlugins.vim-fugitive.overrideAttrs (old: {
    patches = [
      (pkgs.fetchpatch {
        url = "https://github.com/YorikSar/vim-fugitive/commit/d510c6a27a9bc63e30f3116a2a3817871bd25ef5.patch";
        sha256 = "0pb07qf4mr5iv2w8chqn42p9x1is0g77gvdw5h053n58h7h6wwy6";
      })
    ];
  });
in
{
  programs.neovim = {
    plugins = [
      vim-fugitive
    ];
    extraConfig = ''
      " Use Dispatch for Gpush and Gfetch
      command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
            \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
      command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
            \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>
    '';
  };
}
