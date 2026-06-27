{_}:{
  flake.nixosModules.touch = {pkgs,...}:
  {
    environment.systemPackages = with pkgs; [
      libinput
    ];
  };
}
