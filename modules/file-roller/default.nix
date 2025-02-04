{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.file-roller ];
  home.file.".local/share/applications/org.gnome.FileRoller.desktop".text = "";
}
