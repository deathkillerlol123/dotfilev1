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
      username = user;
      groups = ["wheel" "gamemode" "uinput"];
      home-man = {
        enable = true;
	ext = "hm-backup";
	system = type;
	device = position;
	file = home;
      };
    };
    flatpak = {
       apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard" ];
    };    
    system.stateVersion = "25.11";
  };
}