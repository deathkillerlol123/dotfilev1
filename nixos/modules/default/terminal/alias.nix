{...}: {
  flake.nixosModules.alias = {
    environment.shellAliases = {
      gu = "cd ~/dotfiles/nixos && alejandra . && jj describe -m 'Update' && jj bookmark set main -r @ && jj git push && jj new";
      w = "$HOME/dotfiles/nixos/scripts/Boot-Windows10.sh";
      n = "nh os switch $HOME/dotfiles/nixos/";
      clean = "nix store gc && sudo nix store optimise && nh clean all -k 2";
      t = "cd ~/dotfiles/nixos && nix flake update && n && clean && gu";
      ls = "eza -a --tree -L 1";
      e = "emacs -nw";
      key = "wshowkeys -a bottom -m 20 -b 00000000";
      tv = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history | sed 's|^[^/]*/ *||' | wl-copy";
    };
  };
}
