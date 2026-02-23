#!/usr/bin/env bash

# ---------------------------------------------
# 🔍 Universal Linux Package Search Script
# Searches: APT, Snap, Flatpak
# Usage: ./SearchPackages.sh <search-term>
# ---------------------------------------------

SEARCH_TERM="$1"

if [ -z "$SEARCH_TERM" ]; then
    echo "❌ Please provide a search term."
    echo "Usage: ./SearchPackages.sh <search-term>"
    exit 1
fi

echo ""
echo "=============================================="
echo " 🔎 Searching for: \"$SEARCH_TERM\""
echo "=============================================="
echo ""

# ----------------------------
# 🟣 Snap Search
# ----------------------------
echo "🟣 Snap Results"
echo "----------------------------------------------"
if command -v snap >/dev/null 2>&1; then
    snap find "$SEARCH_TERM"
else
    echo "⚠️  Snap not installed."
fi

echo ""
echo ""

# ----------------------------
# 🔵 Flatpak Search
# ----------------------------
echo "🔵 Flatpak Results"
echo "----------------------------------------------"
if command -v flatpak >/dev/null 2>&1; then
    flatpak search "$SEARCH_TERM"
else
    echo "⚠️  Flatpak not installed."
fi

echo ""
echo ""

# ----------------------------
# 🟢 APT Search
# ----------------------------
echo "🟢 APT Results"
echo "----------------------------------------------"
if command -v apt >/dev/null 2>&1; then
    apt search "$SEARCH_TERM" 2>/dev/null
else
    echo "⚠️  APT not available on this system."
fi

echo ""
echo "✅ Search complete."
echo ""
