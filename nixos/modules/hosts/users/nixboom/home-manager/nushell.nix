{...}: {
  flake.homeModules.nbnu = {...}: {
    programs.nushell = {
      enable = true;
      shellAliases = {
        ls = "eza -a --tree -L 1";
        e = "emacs -nw";
        w = "~/dotfiles/nixos/modules/default/terminal/scripts/Boot-Windows10.sh";
      };
      extraConfig = ''
        def n [] {
          nh os switch ~/dotfiles/nixos/
        }
        def clean [] {
          nix store gc
          sudo nix store optimise
          nh clean all -k 2
        }
      '';
    };
  };
}
