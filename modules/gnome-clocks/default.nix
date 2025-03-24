{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.gnome-clocks ];

  systemd.user.services.gnome-clocks-startup = {
    Unit.Description = "Gnome clocks";
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
        ExecStart = "${pkgs.gnome-clocks}/bin/gnome-clocks --gapplication-service";
        Nice = "-20";
        Restart = "on-failure";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 60;
    };
  };
}
