{self,...}:{
  flake.nixosModules.alias = {
      environment.shellAliases = {
        gu = "$HOME/dotfiles/nixos/scripts/git_updater.sh";
        w  = "$HOME/dotfiles/nixos/scripts/Boot-Windows10.sh";
        n  = "nh os switch $HOME/dotfiles/nixos/";
        t  = "gu && nix flake update && n && nix store gc && sudo nix store optimise && nh clean all -k 2 && gu";
        ls = "eza -a --tree -L 1";
        e  = "emacs -nw";
        key = "wshowkeys -a bottom -m 20 -b 00000000";
      };
    };
}
