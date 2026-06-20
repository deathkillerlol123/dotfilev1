{inputs,self,...}:
let
  user = "doct";
in
{
  flake.nixosModules.doct = {config,lib,pkgs,inputs,...}:{
    imports = with self.nixosModules; [
      uxplay
      main
      kde
    ];
    environment.systemPackages = with pkgs; [
      firefox
      anki
      whatsapp-electron
      libreoffice
    ];
    services.displayManager.cosmic-greeter.enable = true;
  };
}