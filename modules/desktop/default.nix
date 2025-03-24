{
  pkgs,
  ...
}:

let
  audioPlayer = "io.bassi.Amberol.desktop";
  browser = "zen.desktop";
  editor = "org.gnome.TextEditor";

  gtkCss = ''
    @define-color accent_bg_color #9141ac;
    @define-color accent_color @accent_bg_color;

    :root {
      --accent-bg-color: @accent_bg_color;
    }
  '';

  imageViewer = "org.gnome.Loupe.desktop";
  videoPlayer = "org.gnome.Showtime";
  wallpaper = "file:///home/icedborn/Pictures/wallpaper.jpg";
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
    "org/gnome/desktop/interface" = {
      accent-color = "purple";
      color-scheme = "prefer-dark";
      clock-show-seconds = true;
      clock-show-date = false;
      clock-show-weekday = false;
      show-battery-percentage = true;
      enable-hot-corners = false;
    };

    "org/gnome/desktop/background".picture-uri = wallpaper;
    "org/gnome/desktop/background".picture-uri-dark = wallpaper;
    "org/gnome/desktop/screensaver".picture-uri = wallpaper;

    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
      remove-old-temp-files = true;
    };

    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
      date-format = "with-time";
      show-type-column = false;
      show-hidden = true;
    };

    "org/sigxcpu/feedbackd/application/mobi-phosh-shell".profile = "silent";
    "sm/puri/phoc".scale-to-fit = true;
    "sm/puri/phosh".favorites = [ ];

    "sm/puri/phosh/plugins".quick-settings = [
      "wifi-hotspot-quick-setting"
      "mobile-data-quick-setting"
    ];
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

    file = {
      ".config/gtk-4.0/gtk.css".text = gtkCss;
      "Pictures/wallpaper.jpg".source = ./wallpaper.jpg;
    };
  };
}
