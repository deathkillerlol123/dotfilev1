{...}: {
  flake.homeModules.nbstarship = {...}: {
    programs.starship = {
      enable = true;
      settings = {
        format = ''
          ~❯
        '';
        right_format = ''
          $time
        '';
        localip = {
          disabled = true;
          ssh_only = false;
          format = "[$localipv4](bold red) ";
        };
        username = {
          style_user = "green bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          format = "[$hostname](bold red) ";
          trim_at = ".";
          disabled = false;
        };
        git_branch.disabled = false;
        git_status.disabled = true;
        shell.disabled = false;
        directory = {
          truncation_length = 1;
          truncate_to_repo = false;
          style = "bold italic blue";
          disabled = true;
        };
        cmd_duration.disabled = true;
        time.disabled = true;
      };
    };
  };
}
