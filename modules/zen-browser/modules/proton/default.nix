{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "proton" "zen --no-remote -P proton --name proton https://mail.proton.me")
  ];
}
