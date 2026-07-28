{
  flake.nixosModules.system = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nix-option-search.modules.default];
    documentation.option-search.enable = true;
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
      inputs.nix-option-search.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      maple-mono.NF
    ];
  };
}
