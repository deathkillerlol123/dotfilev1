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
        graphviz
        starship
        bash
        zoxide
        emacs
        nixd
        nixfmt
        zathura
        eza
        bat
        bottom
        fastfetch
        fd
        statix
        yazi
        kdePackages.dolphin
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
