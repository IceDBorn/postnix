#!/usr/bin/env bash

IDENTIFIER="# File appended"
PAM_FILE="/etc/pam.d/common-password"

appendFile() {
    local file="$1"
    local content="$2"

    if ! grep -q "$IDENTIFIER" "$file"; then
        cat <<EOF >> "$file"
$content
EOF
        echo "Added extra config to $file successfully"
    fi
}

# Check if password length limitations are already removed
if ! grep -q "minlen=1" "$PAM_FILE"; then
    # Remove the password length limitations
    if sudo sed -i 's|pam_unix.so obscure yescrypt|pam_unix.so minlen=1 obscure yescrypt|' "$PAM_FILE"; then
        echo "Password length limitations removed"
    else
        echo "Failed to remove password length limitations. Check permissions or try again."
        exit 1
    fi
fi

# Add extra config to .bashrc
appendFile ~/.bashrc '\$SSH_CONNECTION' '
if [[ -n $SSH_CONNECTION ]]; then

bashRc=$(
    cat << EOF
$IDENTIFIER
if [[ -n \$SSH_CONNECTION ]]; then
  sh -c "gnome-session-inhibit --inhibit suspend --reason \"SSH connection active\" --inhibit-only > /dev/null 2>&1 &"
fi

alias update="sudo apt update -y && sudo apt upgrade -y ; sudo flatpak update -y"
alias rmodem="sudo systemctl restart ModemManager.service"
alias rwayd="sudo waydroid container restart"

EOF
)

profile=$(
    cat << EOF
$IDENTIFIER
gnome-clocks --hidden &
chatty --daemon &
EOF
)

# Add extra config to .bashrc
appendFile ~/.bashrc "$bashRc"

# Add extra config to .profile
appendFile ~/.profile "$profile"
