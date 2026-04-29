{inputs,self,...}:
{
  flake.nixosConfigurations.nixbtw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
    [
      inputs.home-manager.nixosModules.home-manager
    ]++
    (with self.nixosModules; [
      main
      boomlaptopconf
      boomware
    ]);    
  };
  flake.nixosModules.boomlaptopconf = { config, lib, pkgs, inputs,... }:{    
    lime = {
      enable = true;
      wallpapers = "${self.outPath}/themes/limine_wallpaper";      
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
      flake = self.outpath;
    };
    flatpak = {
      enable = true;
      apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard" ];
    };
    home-man = {
      enable = true;
      ext = "hm-backup";
      home = "${self.outPath}/modules/hosts/nixboom/_home.nix";
    };
    nix.settings.trusted-users = [ "root" "nixboom" ];
    system.stateVersion = "25.11";
  };
}
 
