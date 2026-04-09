{lib, config, pkgs, ...}: {
  options = {
    main-user = lib.mkOption {
      type = lib.types.listOf {
        type = rec {
          userName = lib.mkOption { type = lib.types.string; };
          shell = lib.mkOption { type = lib.types.string; default = "bash"; };
          flakelocation = lib.mkOption { type = lib.types.string; default = "/etc/nixos/"; };
          groups = lib.mkOption { type = lib.types.listOf lib.types.string; default = ["wheel"]; };
          enable = lib.mkOption { type = lib.types.bool; default = true; };
        };
      };
      default = [];
    };
  };

  config = lib.mkIf (lib.any (user: user.enable) config.main-user) {
    users.users = lib.foldl' (acc, user: acc // {
      ${user.userName} = {
        isNormalUser = true;
        shell = pkgs.${user.shell};
        extraGroups = user.groups;
      };
    }) {} (filter (user: user.enable) config.main-user);

    security.sudo.extraRules = lib.concatLists (map (user: {
      users = [ user.userName ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }) (filter (user: user.enable) config.main-user));

    config.programs = {
      bash.enable = true;
      zsh.enable = true;
      nh = {
        enable = true;
        clean.enable = true;
        flake = config.main-user.flakelocation;
      };
      nix-ld = {
        enable = true;
      };
    };
  };
}