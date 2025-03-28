{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) replaceStrings;
  dbusName = "org.gnome.Maps";
  package = pkgs.gnome-maps;
in
{
  home.packages = [ package ];

  home.file.".local/share/applications/${dbusName}.desktop".text =
    replaceStrings [ "DBusActivatable=true" ] [ "" ]
      (builtins.readFile "${package}/share/applications/${dbusName}.desktop");
}
