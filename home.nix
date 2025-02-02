{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) filterAttrs;

  driversEnv =
    with pkgs;
    buildEnv {
      name = "graphics-drivers";
      paths = [ mesa.drivers ];
    };

  getModules =
    path:
    builtins.map (dir: ./. + ("/modules/" + dir)) (
      builtins.attrNames (filterAttrs (n: v: v == "directory") (builtins.readDir path))
    );
in
{
  imports = getModules (./modules);

  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";
  home.username = "user";

  home.packages = with pkgs; [
    (runCommand "graphics-drivers" { } ''
      mkdir -p $out/drivers ; cd $out/drivers
      ln -s "${driversEnv}" opengl-driver
    '')

    authenticator
    calls
    celluloid
    flare-signal
    fractal
    git
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-text-editor
    harmony-music
    loupe
    newsflash
    nixfmt-rfc-style
    protonvpn-gui
    snapshot
  ];
}
