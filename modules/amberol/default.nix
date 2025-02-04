{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.amberol ];
  home.file.".local/share/applications/io.bassi.Amberol.desktop".text = "";
}
