{inputs,self,...}:
let
  user = "doct";
in
{
  flake.nixosModules.doct = {config,lib,pkgs,inputs,...}:{
    imports = with self.nixosModules; [
      uxplay main
    ];
    environment.systemPackages = with pkgs; [
      firefox anki whatsapp-electron libreoffice
    ];
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    boot.loader= {
      refind.enable = true;
      efi = {
        canTouchEfiVariables = true;
	systemdBoot.enable = false;
      };
    };
  };
}