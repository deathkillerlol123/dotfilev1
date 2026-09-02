{...}: {
  flake.homeModules.default = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "volume_increase" ''
        amixer set Master 5%+
      '')
      (pkgs.writeShellScriptBin "volume_decrease" ''
        amixer set Master 5%-
      '')
      (pkgs.writeShellScriptBin "volume_mute" ''
        amixer set Master toggle
      '')
      (pkgs.writeShellScriptBin "clean_exit" ''
        loginctl terminate-session "$XDG_SESSION_ID"
      '')
    ];
  };
}
