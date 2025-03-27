{
  pkgs,
  ...
}:

let
  package = pkgs.gnome-clocks;
in
{
  home.packages = [ package ];

  systemd.user.services.gnome-clocks = {
    Unit.Description = "Gnome clocks";

    Service = {
      BusName = "org.gnome.clocks";
      ExecStart = "${package}/bin/gnome-clocks";
      Nice = "-20";
      Restart = "on-failure";
      StartLimitBurst = 60;
      Type = "dbus";
    };
  };
}
