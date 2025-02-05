{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "startup-script" ''
      flare --gapplication-service &
      fractal --gapplication-service &
      gnome-clocks --gapplication-service &
    '')
  ];

  home.files.".profile" = ''
    startup-script
  '';
}
