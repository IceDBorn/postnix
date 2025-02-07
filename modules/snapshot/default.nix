{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.snapshot ];
  dconf.settings."org/gnome/Snapshot".play-shutter-sound = false;
}
