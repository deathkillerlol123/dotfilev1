{inputs,self,...}:
let
  user = "nixboom";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      uxplay fish
      dragware main
    ];
    home-man = {
      enable = true;
      username = user;
    };
    lime = {
      enable = true;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1"];
      windows = {
        enable = true;
	location = windows_efi;
      };
    };
    flatpak.apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard"];
    networking.firewall = {
      allowedTCPPorts = [ 6642 ];
      allowedUDPPorts = [ 6642 ];
    };
    system.stateVersion = "25.11";
  };
}