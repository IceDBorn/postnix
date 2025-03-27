{
  pkgs,
  ...
}:

let
  package = pkgs.chatty;
in
{
  home.packages = [ package ];
  dconf.settings."org/sigxcpu/feedbackd/application/sm-puri-chatty".profile = "silent";

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  systemd.user.services.chatty = {
    Unit.Description = "Chatty";

    Service = {
      BusName = "sm.puri.Chatty";
      ExecStart = "${package}/bin/chatty --gapplication-service";
      Nice = "-20";
      Restart = "on-failure";
      StartLimitBurst = 60;
      Type = "dbus";
    };
  };
}
