{inputs,self,...}:
let
  user = "nixboom";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom = {config,lib,pkgs,inputs,... }:{
    imports = [
       self.nixosModules.uxplay
       self.nixosModules.gaming
       self.nixosModules.fish
       self.nixosModules.windows
       self.nixosModules.dragware
       self.nixosModules.main
       self.nixosModules.lime
       self.nixosModules.home-man
       self.nixosModules.flatpak
       inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
    home-man = {
      enable = true;
      username = user;
    };
    lime = {
      enable = true;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1"];
      windows.location = windows_efi;
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;
    flat.apps = [ "ch.openboard.OpenBoard" "org.vinegarhq.Sober" ];
    programs.mangowc.enable = true;
    networking.firewall = {
      allowedTCPPorts = [ 6642 443 ];
      allowedUDPPorts = [ 6642 443];
    };
    system.stateVersion = "25.11";
  };
}