{inputs,self,...}:{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.laptopmodule
      self.nixosModules.lapware
      self.nixosModules.aesthetics
      self.nixosModules.flatpak
    ];
  };
  flake.nixosModules.laptopmodule = { config, lib, pkgs, inputs, self, ... }:{
    imports = [
      ./laptop-hardware.nix
    ];
    lime = {
      enable = true;
      wallpapers = ../../themes/limine_wallpaper;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
      windows = {
        enable = true;
        location = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
      };
    };
    main-user = {
      enable = true;
      userName = "nixboom";
      groups = ["wheel" "gamemode" "uinput"];
      flakelocation = "/home/nixboom/dotfiles/nixos/";
    };
    home-man = {
      enable = true;
      ext = "hm-backup";
      home = ./home.nix;
    };
    flatpak = {
      enable = true;
      apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard" ];
    };
    system.stateVersion = "25.11";
  };
}
 