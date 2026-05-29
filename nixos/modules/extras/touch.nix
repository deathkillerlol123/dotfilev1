{inputs,self,...}:{
  flake.nixosModules.touch = {config,lib,pkgs,inputs,...}:
  {
    environment.systemPackages = with pkgs; [
      python312Packages.evdev
      libinput
    ];
  };
}