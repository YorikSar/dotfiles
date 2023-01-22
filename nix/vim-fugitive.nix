{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      vim-rhubarb
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
