#!/usr/bin/env bash

OPTIONS=(
    "org.gnome.desktop.datetime automatic-timezone false"
    "org.gnome.desktop.input-sources sources \"[('xkb', 'us'), ('xkb', 'gr')]\""
    "org.gnome.desktop.interface clock-show-seconds true"
    "org.gnome.desktop.interface color-scheme 'prefer-dark'"
    "org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'"
    "org.gnome.desktop.interface show-battery-percentage true"
    "org.gnome.desktop.privacy remember-recent-files false"
    "org.gnome.desktop.session idle-delay 60"
    "org.gnome.nautilus.preferences click-policy 'double'"
    "org.gnome.nautilus.preferences show-create-link true"
    "org.gnome.nautilus.preferences show-delete-permanently true"
    "org.gnome.settings-daemon.plugins.power ambient-enabled false"
    "org.gtk.gtk4.Settings.FileChooser sort-directories-first true"
)

for option in "${OPTIONS[@]}"
do
    if echo "$option" | xargs gsettings set; then
        echo "Set $option successfully"
    else
        echo "Failed to set $option"
        exit 1
    fi
done
