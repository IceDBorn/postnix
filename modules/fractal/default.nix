{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) replaceStrings;
  dbusName = "org.gnome.Fractal";
  package = pkgs.fractal;
in
{
  home.packages = [ package ];

  home.file.".local/share/applications/${dbusName}.desktop".text =
    replaceStrings [ "DBusActivatable=true" ] [ "" ]
      (builtins.readFile "${package}/share/applications/${dbusName}.desktop");
}
