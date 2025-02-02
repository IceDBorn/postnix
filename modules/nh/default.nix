{
  pkgs,
  ...
}:

let
  extraArgs = "-k 1 -K 0d";
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "nix-gc" "nh clean all ${extraArgs}")
  ];

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = extraArgs;
      dates = "Mon *-*-* 00:00:00";
    };
  };
}
