{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) replaceStrings;
  package = pkgs.gnome-contacts;
  dbusName = "org.gnome.Contacts";
in
{
  home.packages = [ package ];

  home.file.".local/share/applications/${dbusName}.desktop".text =
    replaceStrings [ "DBusActivatable=true" ] [ "" ]
      (builtins.readFile "${package}/share/applications/${dbusName}.desktop");
}
