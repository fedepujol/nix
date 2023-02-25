{ pkgs, ... }:

{
  programs = {
    wezterm = {
      enable = true;
      extraConfig = ''
          ${builtins.readFile ./lua/init.lua}
        '';
    };
  };
}
