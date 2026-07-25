{
  flake.nixosModules.system = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      os-prober
      efibootmgr
      curl
      zip
      git
      jujutsu
      gh
      libnotify
      brightnessctl
      borgbackup
      ntfs3g
      starship
      bash
      zoxide
      emacs
      nixd
      alejandra
      zathura
      eza
      bat
      bottom
      fastfetch
      fd
    ];
    fonts.packages = with pkgs.nerd-fonts; [
      fira-code
      droid-sans-mono
      dejavu-sans-mono
    ];
  };
}
