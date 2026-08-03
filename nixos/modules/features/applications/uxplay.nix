{...}: {
  flake.nixosModules.uxplay = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options = {
      uxplay.enable = lib.mkEnableOption "uxplay";
    };
    config = lib.mkIf config.uxplay.enable {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          hinfo = true;
          userServices = true;
          workstation = true;
          domain = true;
        };
      };
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [7000 7100 7001];
        allowedUDPPorts = [5353 6000 6001 7011];
      };
      environment.systemPackages = [
        pkgs.uxplay
        pkgs.avahi
        (pkgs.writeTextFile {
          name = "uxplay.desktop";
          destination = "/share/applications/uxplay.desktop";
          text = ''
            [Desktop Entry]
            Name=Uxplay Toggle
            Exec=sh -c 'CHOICE=$(printf "Start uxplay\nStop uxplay" | rofi -dmenu -p "UxPlay"); case "$CHOICE" in "Start uxplay") pgrep -x uxplay >/dev/null || uxplay -p & ;; "Stop uxplay") pkill uxplay ;; esac'
            Terminal=false
            Type=Application
            Icon=terminal
            Categories=Utility;
          '';
        })
      ];
    };
  };
}
