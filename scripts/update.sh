#!/usr/bin/env bash

if sudo apt upgrade -y; then
    echo "Updated native packages successfully"
else
    echo "Failed to update native packages. Check your internet connection or try again."
    exit 1
fi

if sudo flatpak update -y; then
    echo "Updated flatpak packages successfully"
else
    echo "Failed to update flatpak packages. Check your internet connection or try again."
    exit 1
fi
