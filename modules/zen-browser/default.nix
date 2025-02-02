{
  lib,
  zen-browser,
  ...
}:

let
  inherit (lib) filterAttrs;

  package = zen-browser;

  getModules =
    path:
    builtins.map (dir: ./. + ("/modules/" + dir)) (
      builtins.attrNames (
        filterAttrs (n: v: v == "directory" && !(n == "zen-browser")) (builtins.readDir path)
      )
    );
in
{
  imports = getModules (./modules);
  home.sessionVariables.DEFAULT_BROWSER = "${package}/bin/zen";

  home.file = {
    ".zen/profiles.ini" = {
      source = ./profiles.ini;
      force = true;
    };
  };

  home.packages = [ package ];

  xdg.desktopEntries.proton = {
    exec = "proton";
    icon = "proton";
    name = "Proton";
    terminal = false;
    type = "Application";
  };
}
