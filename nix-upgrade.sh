#!@runtimeShell@

set -eo pipefail

main() {
    echo "Updating root channels..."
    sudo -i nix-channel --update
    echo "Updating nix..."
    sudo -i nix-env -iA nixpkgs.nix
    echo "Updating root profile..."
    sudo -i nix-env -u
    echo "Restarting Nix daemon..."
    sudo launchctl remove org.nixos.nix-daemon
    sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    if [ "$USER" != "root" ]; then
        echo "Updating user channels..."
        nix-channel --update
        echo "Updating user profile..."
        nix-env -u
        echo "Updating home-manager..."
        home-manager switch
    fi
}

main
