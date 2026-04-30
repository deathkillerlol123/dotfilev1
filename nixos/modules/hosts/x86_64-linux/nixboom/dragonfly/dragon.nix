{inputs,self,...}:
let
  type = "x86_64-linux";
  user = "nixboom";
  position = "dragonfly";
  home = "_home.nix";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.dragon = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      inputs.home-manager.nixosModules.home-manager    
      main      
      dragboomware
    ];
    lime = {
      enable = true;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
      windows = {
        enable = true;
        location = windows_efi;
      };
    };
    main-user = {
      enable = true;
      userName = user;
      groups = ["wheel" "gamemode" "uinput"];
    };
    flatpak = {
      enable = true;
      apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard" ];
    };
    home-man = {
      enable = true;
      ext = "hm-backup";
      system = type;
      username = user;
      device = position;
      file = home;
    };
    system.stateVersion = "25.11";
  };
}