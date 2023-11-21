#/usr/bin/env bash

REPO_URL="https://codeberg.org/jayvii/pinephone-scripts.git"
SCRIPTS_DIR="pinephone-scripts"

# Clone repository if not already present
if [ ! -d "$SCRIPTS_DIR" ]; then
    if ! git clone "$REPO_URL"; then
        echo "Failed to clone pinephone-scripts. Check your internet connection or try again."
        exit 1
    fi
fi

# Install and configure sguard
if [ -d "$SCRIPTS_DIR" ]; then
    # Change to the sguard directory
    cd "$SCRIPTS_DIR/sguard"

    # Install sguard
    make install

    # Move back to the original directory
    cd ../..

    # Clean up by removing the cloned repository
    rm -rf "$SCRIPTS_DIR"

    # Enable and start sguard service
    if systemctl enable --user sguard --now; then
        echo "Installed sguard successfully"
    else
        echo "Failed to install sguard."
        exit 1
    fi
fi
