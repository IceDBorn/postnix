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

  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";
  home.username = "user";

  home.packages = with pkgs; [
    amberol
    authenticator
    calls
    curl
    file-roller
    flare-signal
    fractal
    git
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-software
    gnome-text-editor
    harmony-music
    lazygit
    loupe
    nano
    newsflash
    nixfmt-rfc-style
    protonvpn-gui
    showtime
    snapshot
  ];
}
