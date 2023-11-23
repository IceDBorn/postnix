#/usr/bin/env bash

NATIVE_PACKAGES=(
    "adb"
    "bpytop"
    "curl"
    "dconf-cli"
    "dconf-editor"
    "gnome-disk-utility"
    "gnome-tweaks"
    "iotas"
    "kdeconnect"
    "libnotify-bin"
    "make"
    "nautilus"
    "neovim"
    "otpclient"
    "powersupply-gtk"
    "python3-pip"
    "python3-venv"
    "waydroid"
    "wf-recorder"
    "wl-clipboard"
)

FLATPAK_PACKAGES=(
    "app/app.drey.Warp/aarch64/stable"
    "app/com.github.GradienceTeam.Gradience/aarch64"
    "app/com.github.tchx84.Flatseal/aarch64/stable"
    "app/org.gnome.Loupe/aarch64/stable"
    "de.haeckerfelix.Fragments"
    "io.github.giantpinkrobots.flatsweep/aarch64/stable"
    "org.gabmus.whatip"
)

PURGE_PACKAGES=(
    "eog"
    "epiphany-browser"
    "evince"
    "g4music"
    "gnome-maps"
    "phosh-tour"
    "portfolio-filemanager"
)

# Install packages
if sudo apt update -y; then
    echo "Mirrors updated successfully"
else
    echo "Could not update mirrors. Check your internet connection or try again."
    exit 1
fi

if sudo apt install -y "${NATIVE_PACKAGES[@]}"; then
    echo "Native packages installed successfully"
else
    echo "Failed to install native packages. Check your internet connection or try again."
    exit 1
fi

if sudo flatpak install -y "${FLATPAK_PACKAGES[@]}"; then
    echo "Flatpak packages installed successfully"
else
    echo "Failed to install flatpak packages. Check your internet connection or try again."
    exit 1
fi

# Remove packages
if sudo apt purge -y "${PURGE_PACKAGES[@]}"; then
    echo "Packages removed successfully"
else
    echo "Failed to remove packages."
    exit 1
fi

if sudo apt autoremove -y; then
    echo "Packages purged successfully"
else
    echo "Failed to purge packages."
    exit 1
fi
