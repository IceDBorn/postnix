{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.flare-signal ];

  dconf.settings = {
    "de/schmidhuberj/Flare".notifications = true;
    "org/sigxcpu/feedbackd/application/de-schmidhuberj-flare".profile = "silent";
  };
}
