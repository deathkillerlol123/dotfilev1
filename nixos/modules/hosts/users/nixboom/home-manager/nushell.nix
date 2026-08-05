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
        def gu [] {
          cd ~/dotfiles/nixos
          alejandra .
          jj describe -m "Update"
          jj bookmark set main -r @
          jj git push
          jj new
        }
        def n [] {
          nh os switch ~/dotfiles/nixos/
        }
        def clean [] {
          nix store gc
          sudo nix store optimise
          nh clean all -k 2
        }
        def t [] {
          cd ~/dotfiles/nixos
          nix flake update
          n
          clean
          gu
        }
        def key [] {
          wshowkeys -a bottom -F "Sans Bold 30" -s "#B5B520ff" -f "#ecd29cff" -b "#201B1488" -t 1
        }
        def tv [] {
          nix-search-tv print
          | fzf --preview "nix-search-tv preview {}" --scheme history
          | sed "s|^[^/]*/ *||"
          | wl-copy
        }
      '';
    };
  };
}
