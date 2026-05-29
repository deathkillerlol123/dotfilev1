{inputs,self,...}:{
  flake.nixosModules.touch = {config,lib,packages,inputs,...}:
  {
    environmen.systemPackages = with pkgs; [
      evdev-proto
    ];
  };
}