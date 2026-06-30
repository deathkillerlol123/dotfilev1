{self,...}:{
  flake.nixosModules.alias = {...}:
    {
      environment.shellAliases = {
        gu = "${self.outPath}/scripts/git_updater.sh";
        w  = "${self.outPath}/scripts/Boot-Windows10.sh";
        n  = "gu && sudo nixos-rebuild switch --flake ~/dotfiles/nixos --upgrade";
        t  = "n && nix store gc && sudo nix store optimise && nh clean all --keep 3 && rm -rf ~/.cache/* && gu";
        ls = "eza -a --tree -L 1";
        e  = "emacs -nw";
        s  = "statix check ~/dotfiles/nixos";
        key = "wshowkeys -a bottom -m 20 -b 00000000";
      };
    };
}
