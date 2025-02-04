{
  pkgs,
  ...
}:

{
  home = {
    packages = [ pkgs.btop ];

    file = {
      ".config/btop/btop.conf".source = ./btop.conf;
      ".local/share/applications/btop.desktop".text = "";
    };
  };
}
