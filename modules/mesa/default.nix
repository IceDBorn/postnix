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

    (writeShellScriptBin "enable-mesa-symlink-service" ''
      SERVICE_NAME="symlink-mesa-driver"
      SERVICE_FILE="/etc/init.d/$SERVICE_NAME"
      SOURCE_DIR="/home/user/.nix-profile/drivers/opengl-driver"
      TARGET_DIR="/run/opengl-driver"

      [ -f "$SERVICE_FILE" ] && echo "Service already installed" && exit

      cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
      #!/sbin/openrc-run

      depend() {
          need localmount
          before display-manager
      }

      start() {
          ebegin "Symlinking mesa driver"
          ln -sf "$SOURCE_DIR" "$TARGET_DIR"
          eend \$?
      }

      stop() {
          ebegin "Removing symlink for mesa driver"
          rm -f "$TARGET_DIR"
          eend \$?
      }
      EOF

      sudo chmod +x "$SERVICE_FILE"
      sudo rc-update add "$SERVICE_NAME" default
      sudo /etc/init.d/"$SERVICE_NAME" start
    '')
  ];
}
