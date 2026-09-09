{...}: {
  flake.homeModules.nbnu = {...}: {
    programs = {
      nushell = {
        enable = true;
        shellAliases = {
          e = "emacs -nw";
        };
        extraConfig = ''
          def gu [] {
            cd ~/dotfiles/nixos
            alejandra .
            jj describe -m "Update"
            jj bookmark set main -r @
            jj git push
          }
          def n [] {
            nh os switch ~/dotfiles/nixos/
          }
          def t [] {
            cd ~/dotfiles/nixos
            nix flake update
            n
            nix store gc
            sudo nix store optimise
            nh clean all -k 2
            gu
          }
          def tv [] {
              let x = (nix-search-tv print | fzf --preview "nix-search-tv preview {}" --scheme history)
              let p = ($x | sed "s|^[^/]*/ *||")
              $p | wl-copy
              if ($x | str starts-with "nixpkgs/") { nix-shell -p $p }
          }
          $env.config.show_banner = false
        '';
      };
      nix-search-tv.enableTelevisionIntegration = true;
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}
