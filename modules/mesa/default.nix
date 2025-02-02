{
  pkgs,
  ...
}:

let
  driversEnv =
    with pkgs;
    buildEnv {
      name = "graphics-drivers";
      paths = [ mesa.drivers ];
    };
in
{
  home.packages = with pkgs; [
    (runCommand "graphics-drivers" { } ''
      mkdir -p $out/drivers ; cd $out/drivers
      ln -s "${driversEnv}" opengl-driver
    '')

    (writeShellScriptBin "symlink-mesa-drivers" ''
      sudo ln -s $HOME/.nix-profile/drivers/opengl-driver /run/opengl-driver
    '')
  ];
}
