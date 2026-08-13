{...}: {
  flake.homeModules.nbnu = {...}: {
    programs.nushell = {
      enable = true;
      shellAliases = {
        e = "emacs -nw";
      };
      extraConfig = ''
        def w [] {
          run-external ($env.HOME | path join "dotfiles/nixos/modules/default/terminal/scripts/Boot-Windows10.sh")
        }

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
        def lsblk [] {
            ^lsblk -J
            | from json
            | get blockdevices
            | each {|disk|
                [$disk] ++ ($disk.children? | default [])
            }
            | flatten
            | select name size type mountpoints
        }

        $env.config.show_banner = false
      '';
    };
  };
}
