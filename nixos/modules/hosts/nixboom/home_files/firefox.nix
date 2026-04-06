{ config, pkgs, inputs, ...}:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.5lrleefc.declaritive = {
      extensions = [
        inputs.firefox-addons.packages."x86_64".block-origin
      ];
    };
}
