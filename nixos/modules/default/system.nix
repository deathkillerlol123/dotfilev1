{...}:
{
  flake.nixosModules.system =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        os-prober
        efibootmgr
        curl
        zip
        git
        gh
        libnotify
        brightnessctl
        borgbackup
        ntfs3g
        starship
        bash
        zoxide
        emacs
        nixfmt
        deadnix
        nixd
        eza
        bat
        bottom
        fastfetch
        fd
        statix
        yazi
      ];
      fonts.packages =
        with pkgs;
        with nerd-fonts;
        [
          fira-code
          droid-sans-mono
          dejavu-sans-mono
        ];
    };
}
