{
  pkgs,
  ...
}:

let
  driversEnv =
    with pkgs;
    buildEnv {
      name = "graphics-drivers";
      paths = [ mesa ];
    };
in
{
  home.packages = with pkgs; [
    (runCommand "graphics-drivers" { } ''
      mkdir -p $out/drivers ; cd $out/drivers
      ln -s "${driversEnv}" opengl-driver
    '')

    (writeShellScriptBin "enable-mesa-tmpfile" ''
      TMPFILES_CONFIG="/etc/tmpfiles.d/99-nix-ogl.conf"

      [ -f "$TMPFILES_CONFIG" ] && echo "Tmpfiles config already installed" && exit

      cat <<EOF | sudo tee "$TMPFILES_CONFIG" > /dev/null
        L+ /run/opengl-driver - - - - /home/icedborn/.nix-profile/drivers/opengl-driver
      EOF
    '')
  ];
}
