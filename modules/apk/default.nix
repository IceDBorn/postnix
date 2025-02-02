{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "remove-packages" ''
      sudo apk del gnome-software flatpak papers firefox-esr gnome-calculator gnome-calendar calls snapshot celluloid gnome-clocks gnome-console gnome-contacts loupe gnome-maps gnome-text-editor gnome-weather postmarketos-welcome decibels showtime
    '')

    (pkgs.writeShellScriptBin "install-packages" ''
      sudo apk add postmarketos-base-ui-audio-pipewire
    '')
  ];
}
