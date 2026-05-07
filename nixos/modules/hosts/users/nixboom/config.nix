{inputs,self,...}:
let
  type = "x86_64-linux";
  user = "nixboom";
  home = "_home.nix";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main
      dragboomware
    ];
    home-man = {
      enable = true;
      username = user;
      ext = "hm-backup";
      system = type;
      file = home;
    };
    lime = {
      enable = true;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
      windows = {
        enable = true;
        location = windows_efi;
      };
    };    
    flatpak.apps = ["org.vinegarhq.Sober" ];
    services.flatpak.packages = [
      "com.obsproject.Studio"
    ];
    system.stateVersion = "25.11";
  };
}