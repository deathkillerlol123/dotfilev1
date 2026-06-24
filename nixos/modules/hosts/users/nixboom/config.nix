{inputs,self,...}:
let
  user = "nixboom";
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom = {config,lib,pkgs,inputs,... }:{
    imports = with self.nixosModules; [
       gaming fish windows main dragware lime
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
      wdisplays firefox-devedition whatsapp-electron
      (discord.override {
        withOpenASAR = true;
      })
      swww pywal swaynotificationcenter swaylock rofi bzmenu
      pwmenu copyq grim slurp swappy wl-clipboard wezterm
      python312 kdePackages.kdeconnect-kde
   ];
   programs.weylus.enable = true;
   programs.weylus.openFirewall = true; # Opens ports 1701 and 9001
   programs.weylus.users = [ "your_username" ]; # Replace with your actual username
 
   # Allow access to uinput for stylus/multitouch support
   boot.kernelModules = [ "uinput" ];
   hardware.uinput.enable = true; 
   services.udev.extraRules = ''
     KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
   '' ;    
    system.stateVersion = "25.11";
  };
}