{...}: {
  flake.nixosModules.alias = {
    environment.shellAliases = {
      gu = "cd ~/dotfiles/nixos && alejandra . && jj describe -m 'Update' && jj bookmark set main -r @ && jj git push && jj new";
      w = "$HOME/dotfiles/nixos/modules/default/terminal/scripts/Boot-Windows10.sh";
      n = "nh os switch $HOME/dotfiles/nixos/";
      clean = "nix store gc && sudo nix store optimise && nh clean all -k 2";
      t = "cd ~/dotfiles/nixos && n -u && clean && gu";
      ls = "eza -a --tree -L 1";
      e = "emacs -nw";
      tv = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history | sed 's|^[^/]*/ *||' | wl-copy";
    };
  };
}
