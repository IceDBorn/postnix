#!/usr/bin/env bash

MOZILLA_PATH="$HOME/.mozilla/firefox"
PWAS_PATH="shortcuts"
PROFILES_INI="$MOZILLA_PATH/profiles.ini"

# Find Firefox PWA desktop files and extract names without extensions
PWAS=($(find "$PWAS_PATH" -name "firefox-*.desktop" -type f -exec bash -c 'for file; do echo "${file##*/}" | cut -f 1 -d "."; done' _ {} +))

# Profiles 0 and 1 are preconfigured, start indexing from 2
i=2

for pwa in "${PWAS[@]}"
do
    # Check if the PWA already exists in profiles.ini
    if grep -q "$pwa" "$PROFILES_INI"; then
        echo "$pwa present."
    else
        mkdir -p "$MOZILLA_PATH/$pwa"
        cat <<EOF >> "$PROFILES_INI"
[Profile$i]
Name=$pwa
IsRelative=1
Path=$pwa
EOF
        ((i++))
    fi
done
