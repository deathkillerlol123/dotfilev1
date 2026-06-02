{inputs,self,...}:{
  flake.nixosModules.windows = {pkgs,...}:{
    services.displayManager.sessionPackages = [
      (pkgs.writeTextFile {
        name = "windows-session";
	destination = "/share/xsessions/windows.desktop";
	text = ''
          [Desktop Entry]
          Name=Windows
          Comment=Boot Windows
          Exec=/home/nixboom/dotfiles/scripts/Boot-Windows10.sh
          Type=Application
	'';
      } // {
        providedSessions = [ "windows" ];
      })
    ];
  };
}