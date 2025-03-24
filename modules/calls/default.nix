{
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    alsa-utils
    calls
    inotify-tools
  ];

  nixpkgs.overlays = [
    (final: super: {
      calls = super.calls.overrideAttrs (
        finalAttrs: superAttrs: {
          patches = [
            ./patch.nix
          ];

          doCheck = false;
          doInstallCheck = false;
        }
      );
    })
  ];

  systemd.user.services = {
    gnome-calls-startup = {
      Unit.Description = "Gnome calls";
      Install.WantedBy = [ "graphical-session.target" ];

      Service = {
        ExecStart = "${pkgs.calls}/bin/gnome-calls --daemon";
        Nice = "-20";
        Restart = "on-failure";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 60;
      };
    };

    call-audio-handler-startup = {
      Unit.Description = "Call audio handler";
      Install.WantedBy = [ "graphical-session.target" ];

      Service = {
        ExecStart = "${
          let
            inherit (lib) makeBinPath;

            pythonFile = builtins.toFile "script.py" ''
              ${builtins.readFile ./call-audio-handler.py}
            '';
          in
          with pkgs;
          makeBinPath [
            (writeShellScriptBin "call-audio-handler" ''
              export PATH=$PATH:${lib.makeBinPath [ python3 ]}

              python3 ${pythonFile}
            '')
          ]
        }/call-audio-handler";

        Nice = "-20";
        Restart = "on-failure";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 60;
      };
    };
  };
}
