{inputs,self,...}:{
  flake.nixosModules.touch = {config,lib,pkgs,inputs,...}:
  {
    environmen.systemPackages = with pkgs; [
      evdev-proto
    ];
  };
}