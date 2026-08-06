{...}: {
  flake.homeModules.nbnu = {...}: {
    programs.nushell = {
      enable = true;
      shellAliases = {
        e = "emacs -nw";
      };
      extraConfig = ''
        cd ~/dotfiles/nixos
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

        def tv [] {
          nix-search-tv print
          | fzf --preview "nix-search-tv preview {}" --scheme history
          | sed "s|^[^/]*/ *||"
          | wl-copy
        }

        $env.config.show_banner = false
      '';
    };
  };
}
