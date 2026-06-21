{inputs,self,...}:
let
  user = "nixboom";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom = {config,lib,pkgs,inputs,... }:{
    imports = with self.nixosModules; [
       gaming fish
       windows dragware main lime
    ];
    lime = {
      enable = true;
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1"];
      windows.location = windows_efi;
    };
    programs.mangowc.enable = true;
    services.displayManager.ly.enable = true;
    networking.firewall = {
      allowedTCPPorts = [ 6642 443 ];
      allowedUDPPorts = [ 6642 443];
    };    
    environment.systemPackages = with pkgs; [
      ly wdisplays firefox-devedition whatsapp-electron
      (discord.override {
        withOpenASAR = true;
      })
      swww pywal swaynotificationcenter swaylock rofi bzmenu
      pwmenu copyq grim slurp swappy wl-clipboard wezterm
      python312 kdePackages.kdeconnect-kde
   ];    
    system.stateVersion = "25.11";
  };
}