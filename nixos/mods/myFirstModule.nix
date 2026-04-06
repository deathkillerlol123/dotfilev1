{inputs,...}:{
  flake.nixosModules.myFirstModule = { pkgs,...}: {
    programs.firefox.enable = true;
    evironment.systemPackagess = [
      pkgs.vim
    ];
  };
}