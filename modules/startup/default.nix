{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "startup-script" ''
      flare --gapplication-service
      gnome-clocks --gapplication-service
    '')
  ];
}
