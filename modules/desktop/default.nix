{
  pkgs,
  ...
}:

let
  audioPlayer = "io.bassi.Amberol.desktop";
  browser = "zen.desktop";
  editor = "gnome-text-editor";

  gtkCss = ''
    @define-color accent_bg_color #7E57C2;
    @define-color accent_color @accent_bg_color;

    :root {
      --accent-bg-color: @accent_bg_color;
    }
  '';

  imageViewer = "org.gnome.Loupe.desktop";
  videoPlayer = "showtime";
in
{
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Tela-black-dark";
      package = pkgs.tela-icon-theme;
    };

    gtk3.extraCss = gtkCss;
  };

  dconf.settings = {
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
      date-format = "with-time";
      show-type-column = false;
      show-hidden = true;
    };

    "org/gnome/desktop/interface" = {
      accent-color = "#7E57C2";
      color-scheme = "prefer-dark";
      clock-show-seconds = true;
      clock-show-date = false;
      clock-show-weekday = false;
      show-battery-percentage = true;
      enable-hot-corners = false;
    };

    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };

  };

  xdg = {
    configFile = {
      "gtk-4.0/gtk.css".enable = false;
      "mimeapps.list".force = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/json" = editor;
        "application/pdf" = browser;
        "application/x-shellscript" = editor;
        "application/x-wine-extension-ini" = editor;
        "application/x-zerosize" = editor;
        "application/xhtml_xml" = browser;
        "application/xhtml+xml" = browser;
        "application/zip" = "org.gnome.FileRoller.desktop";
        "audio/aac" = audioPlayer;
        "audio/flac" = audioPlayer;
        "audio/m4a" = audioPlayer;
        "audio/mp3" = audioPlayer;
        "audio/wav" = audioPlayer;
        "image/avif" = imageViewer;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/svg+xml" = imageViewer;
        "text/html" = browser;
        "text/plain" = editor;
        "video/mp4" = videoPlayer;
        "video/quicktime" = videoPlayer;
        "video/x-matroska" = videoPlayer;
        "video/x-ms-wmv" = videoPlayer;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;
        "x-www-browser" = browser;
      };
    };
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    file.".config/gtk-4.0/gtk.css".text = gtkCss;
  };
}
