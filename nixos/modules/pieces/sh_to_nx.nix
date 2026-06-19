{ self, pkgs, inputs, ... }:

{
  flake.nixosModules.scripts = { pkgs, lib, ... }:

  let
    root = ../../scripts;

    collectShFiles =
      dir:
      let
        entries = builtins.readDir dir;
      in
        lib.concatLists (lib.mapAttrsToList (name: type:
          let fullPath = "${dir}/${name}";
          in
            if type == "directory" then
              collectShFiles fullPath
            else if type == "regular" && lib.hasSuffix ".sh" name then
              [ fullPath ]
            else
              []
        ) entries);

    scriptFiles = collectShFiles root;

    mkScript = path:
      pkgs.writeShellApplication {
        name = lib.removeSuffix ".sh" (builtins.baseNameOf path);
        text = builtins.readFile path;
      };

    packages = map mkScript scriptFiles;

  in
  {
    environment.systemPackages = packages;
  };
}