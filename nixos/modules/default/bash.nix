{self,... }:
{
  flake.nixosModules.bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        shellAliases = {
          gu = "~/dotfiles/scripts/git_updater.sh";
          n = "gu && sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
          up = "~/dotfiles/scripts/system_updaters/updatesys_Nixos.sh";
          w = "~/dotfiles/scripts/Boot-Windows10.sh";
          t = "gu && up";
          ls = "eza -a --tree -L 1";
          e = "emacs -nw";
          s = "statix check ~/dotfiles/nixos";
        };
      };
    };
}
