{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) filterAttrs;

  getModules =
    path:
    builtins.map (dir: ./. + ("/modules/" + dir)) (
      builtins.attrNames (filterAttrs (n: v: v == "directory") (builtins.readDir path))
    );
in
{
  imports = getModules (./modules);

  home.homeDirectory = "/home/icedborn";
  home.stateVersion = "24.11";
  home.username = "icedborn";

  home.packages = with pkgs; [
    authenticator
    curl
    decoder
    file-roller
    git
    gnome-calculator
    gnome-calendar
    gnome-maps
    gnome-podcasts
    gnome-text-editor
    harmony-music
    lazygit
    loupe
    mousai
    nano
    ncdu
    newsflash
    nixfmt-rfc-style
    openssh
    powersupply
    showtime
  ];
}
