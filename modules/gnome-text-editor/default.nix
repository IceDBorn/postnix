{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.gnome-text-editor ];
  home.file.".local/share/applications/org.gnome.TextEditor.desktop".text = "";
}
