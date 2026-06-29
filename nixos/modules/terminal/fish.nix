{ self, ... }:
{
  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        shellAliases = {
          gu = "${self.outPath}/scripts/git_updater.sh";
          w = "${self.outPath}/scripts/Boot-Windows10.sh";
          t = "${self.outPath}/scripts/system_updaters/updatesys_Nixos.sh";
          n = "gu && sudo nixos-rebuild switch --flake ~/dotfiles/nixos --upgrade";
          ls = "eza -a --tree -L 1";
          e = "emacs -nw";
          s = "statix check ~/dotfiles/nixos";
          key = "wshowkeys -a bottom -m 20 -b 00000000";
        };
      };
      environment.systemPackages = with pkgs; [
        fish
      ];
    };
}
