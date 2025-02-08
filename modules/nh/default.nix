{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "nix-gc" "nh clean user")
  ];

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      dates = "Mon *-*-* 00:00:00";
    };
  };
}
