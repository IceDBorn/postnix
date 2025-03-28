{
  pkgs,
  ...
}:

let
  package = pkgs.flare-signal;
in
{
  home.packages = [ package ];

  systemd.user.services.flare = {
    Unit.Description = "Flare";

    Service = {
      BusName = "de.schmidhuberj.Flare";
      ExecStart = "${package}/bin/flare --gapplication-service";
      Nice = "-20";
      Restart = "on-failure";
      StartLimitBurst = 60;
      Type = "dbus";
    };
  };

  dconf.settings = {
    "de/schmidhuberj/Flare" = {
      notifications = true;
      run-in-background = true;
    };

    "org/sigxcpu/feedbackd/application/de-schmidhuberj-flare".profile = "silent";
  };
}
