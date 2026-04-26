{inputs,...}:{
  flake.nixosModule.fonts = {pkgs,...}:{
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.dejavu-sans-mono
    ];
  };
}
