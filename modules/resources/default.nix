{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.resources ];

  dconf.settings."net/nokyan/Resources" = {
    sidebar-description = true;
    sidebar-details = true;
  };
}
