#!/usr/bin/env bash

VENV_DIR="$HOME/.venvs/pyclip"
BIN_DIR="$HOME/.local/bin"
PYCLIP_PATH="$BIN_DIR/pyclip"

# Install pyclip
if python3 -m venv "$VENV_DIR" && source "$VENV_DIR/bin/activate" && pip install pyclip; then
    deactivate

    # Create bin directory if it doesn't exist
    mkdir -p "$BIN_DIR"

    # Create a symbolic link to pyclip in the bin directory
    ln -s "$VENV_DIR/bin/pyclip" "$PYCLIP_PATH"

    # Add bin directory to the PATH and update .bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"

    echo "Installed pyclip successfully"
else
    echo "Failed to install pyclip."
    exit 1
fi
