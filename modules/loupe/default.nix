{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.loupe ];
  home.file.".local/share/applications/org.gnome.Loupe.desktop".text = "";
}
