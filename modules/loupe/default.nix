{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) replaceStrings;
  dbusName = "org.gnome.Loupe";
  package = pkgs.loupe;
in
{
  home.packages = [ package ];

  home.file.".local/share/applications/${dbusName}.desktop".text =
    replaceStrings [ "DBusActivatable=true" ] [ "" ]
      (builtins.readFile "${package}/share/applications/${dbusName}.desktop");
}
