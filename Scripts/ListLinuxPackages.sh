#!/usr/bin/env bash

echo "========================================="
echo " 📦 Installed Linux Packages Report"
echo "========================================="
echo ""

# ----------------------------
# Snap Packages
# ----------------------------
echo "🟣 Snap Packages"
echo "-----------------------------------------"
if command -v snap >/dev/null 2>&1; then
    snap list
else
    echo "⚠️  Snap not installed."
fi

echo ""
echo ""

# ----------------------------
# Flatpak Packages
# ----------------------------
echo "🔵 Flatpak Packages"
echo "-----------------------------------------"
if command -v flatpak >/dev/null 2>&1; then
    flatpak list --app
else
    echo "⚠️  Flatpak not installed."
fi

echo ""
echo "✅ Package listing complete."

# ----------------------------
# APT Packages
# ----------------------------
echo "🟢 APT Packages"
echo "-----------------------------------------"
if command -v apt >/dev/null 2>&1; then
    apt list --installed 2>/dev/null | sed '1d' | grep -v '\[installed,automatic\]'
else
    echo "⚠️  APT not available on this system."
fi

echo ""
echo ""