#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./flatpak-full-permissions.sh <flatpak-app-id>
#   ./flatpak-full-permissions.sh --system <flatpak-app-id>
#
# Examples:
#   ./flatpak-full-permissions.sh com.usebottles.bottles
#   ./flatpak-full-permissions.sh --system com.usebottles.bottles

SCOPE="--user"

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [--system] <flatpak-app-id>"
    exit 1
fi

if [[ "${1:-}" == "--system" ]]; then
    SCOPE="--system"
    shift
fi

APP_ID="${1:-}"

if [[ -z "$APP_ID" ]]; then
    echo "Usage: $0 [--system] <flatpak-app-id>"
    exit 1
fi

if ! command -v flatpak >/dev/null 2>&1; then
    echo "Error: flatpak is not installed."
    exit 1
fi

if ! flatpak info "$APP_ID" >/dev/null 2>&1; then
    echo "Error: Flatpak '$APP_ID' not found."
    exit 1
fi

echo "Granting broad permissions to $APP_ID using scope $SCOPE..."

if [[ "$SCOPE" == "--system" ]]; then
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO flatpak override "$SCOPE" "$APP_ID" \
    --filesystem=host \
    --device=all \
    --share=network \
    --share=ipc \
    --socket=x11 \
    --socket=wayland \
    --socket=pulseaudio \
    --socket=session-bus \
    --socket=system-bus \
    --allow=bluetooth \
    --allow=devel

echo "Permissions applied successfully."
echo
echo "Verify with:"
echo "flatpak info --show-permissions $APP_ID"