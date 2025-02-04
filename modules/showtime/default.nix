{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.showtime ];
  home.file.".local/share/applications/org.gnome.Showtime.desktop".text = "";
}
