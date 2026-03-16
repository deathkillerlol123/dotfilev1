{ lib, ... }:
{
  fooOption = lib.nixvim.mkRaw "print('hello')";
  plugins.my-plugin.enable = true;
}

