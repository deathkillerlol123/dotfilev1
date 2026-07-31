{self, ...}: {
  flake.nixosModules.alias = {
    environment.shellAliases = {
      gu = "cd ~/dotfiles/ && jj describe -m 'Update' && jj bookmark set main -r @ && jj git push && jj new";
      w = "$HOME/dotfiles/nixos/scripts/Boot-Windows10.sh";
      n = "nh os switch $HOME/dotfiles/nixos/";
      t = "gu && z ~/dotfiles/nixos/ && nix flake update && n && nix store gc && sudo nix store optimise && nh clean all -k 2 && gu";
      ls = "eza -a --tree -L 1";
      e = "emacs -nw";
      key = "wshowkeys -a bottom -m 20 -b 00000000";
      nps = "nix-option-search";
    };
  };
}
