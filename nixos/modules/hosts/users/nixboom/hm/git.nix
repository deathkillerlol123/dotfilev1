{...}: {
  flake.homeModules.nixbgit = {...}: let
    gitidentity = {
      user = {
        name = "deathkillerlol123";
        email = "81639935+deathkillerlol123@users.noreply.github.com";
      };
    };
  in {
    programs = {
      git = {
        enable = true;
        settings =
          gitidentity
          // {
            init.defaultBranch = "main";
            credential.helper = "!gh auth git-credential";
          };
      };
      jujutsu = {
        enable = true;
        settings =
          gitidentity
          // {
            ui = {
              default-command = ["log" "-r" "ancestors(@,5)"];
            };
          };
      };
    };
  };
}
