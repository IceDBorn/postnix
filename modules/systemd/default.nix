{
    lib,
    pkgs,
    ...
}:

let
  command = "dbus-apps-fixer";
in
{
  systemd.user.services.dbus-apps-fixer = {
    Unit.Description = "Dbus apps fixer";
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart = "${
        let
          inherit (lib) makeBinPath;
        in
        with pkgs;
        makeBinPath [
          (writeShellScriptBin command ''
              systemctl restart --user chatty
              systemctl restart --user flare
              systemctl restart --user gnome-clocks
          '')
        ]
      }/${command}";

      Nice = "-20";
      Restart = "on-failure";
      StartLimitIntervalSec = 60;
      StartLimitBurst = 60;
    };
  };
}
