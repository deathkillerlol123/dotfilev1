{self,...}:{
  flake.nixosModules.alias = {
      environment.shellAliases = {
        gu = "$HOME/dotfiles/nixos/scripts/git_updater.sh";
        w  = "$HOME/dotfiles/nixos/scripts/Boot-Windows10.sh";
        n  = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
        t  = "gu && n && nix store gc && sudo nix store optimise && nh clean all --keep 3 && rm -rf ~/.cache/* && z ~/dotfiles/nixos && nix flake update && gu";
        ls = "eza -a --tree -L 1";
        e  = "emacs -nw";
        s  = "statix check ~/dotfiles/nixos";
        key = "wshowkeys -a bottom -m 20 -b 00000000";
      };
    };
}
