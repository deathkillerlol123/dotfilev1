{...}: {
  flake.homeModules.nbnu = {...}: {
    programs.nushell = {
      enable = true;
      shellAliases = {
        ls = "eza -a --tree -L 1";
        e = "emacs -nw";
        n = "nh os switch ~/dotfiles/nixos";
      };
      extraConfig = ''
        $env.config.show_banner = false
        def gu [] {
          cd ~/dotfiles/nixos
          alejandra .
          jj describe -m "Update"
          jj bookmark set main -r @
          jj git push
          jj new
        }
      '';
    };
  };
}
