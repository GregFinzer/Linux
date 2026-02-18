#!/usr/bin/env bash
set -euo pipefail

# Create a Chrome/Chromium "PWA-style" launcher for a URL.
# - Auto-downloads a site icon (favicon / apple-touch-icon best-effort)
# - Removes/replaces any existing launcher + icon for the same URL-derived app id
# - Supports Google Chrome and Chromium
#
# Usage:
#   ./create-pwa.sh https://regex101.com/

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <url>"
  exit 1
fi

URL="$1"

# -------- helpers --------
have() { command -v "$1" >/dev/null 2>&1; }

pick_browser() {
  if have google-chrome; then echo "google-chrome"; return; fi
  if have google-chrome-stable; then echo "google-chrome-stable"; return; fi
  if have chromium-browser; then echo "chromium-browser"; return; fi
  if have chromium; then echo "chromium"; return; fi
  echo "ERROR: Neither Google Chrome nor Chromium found. Install one first." >&2
  exit 1
}

host_from_url() {
  echo "$1" | sed -E 's#^[a-zA-Z]+://##; s#/.*##'
}

safe_slug() {
  echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g; s/-+/-/g'
}

BROWSER="$(pick_browser)"

HOST="$(host_from_url "$URL")"
SLUG="$(safe_slug "$HOST")"
APP_NAME="$HOST"
APP_ID="${SLUG}-pwa"
APP_CLASS="$(echo "$SLUG" | sed -E 's/(^|[-_])([a-z])/\U\2/g')"PWA

ICON_DIR="$HOME/.local/share/icons"
APP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$APP_DIR/${APP_ID}.desktop"
ICON_FILE="$ICON_DIR/${APP_ID}.png"
USER_DATA_DIR="$HOME/.config/${APP_ID}"

mkdir -p "$ICON_DIR" "$APP_DIR"

# -------- remove existing launcher/icon (if any) --------
rm -f "$DESKTOP_FILE" "$ICON_FILE"
if [[ -d "$HOME/Desktop" ]]; then
  rm -f "$HOME/Desktop/${APP_ID}.desktop"
fi

# -------- icon download (best-effort) --------
download_icon() {
  local url="$1"
  local tmpdir base html href icon_url ext
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' RETURN

  if ! have curl; then
    echo "Note: curl not found; skipping icon download."
    return 0
  fi

  base="$(echo "$url" | sed -E 's#^(https?://[^/]+).*$#\1#')"

  # Common favicon locations
  if curl -fsSL "${base}/favicon.ico" -o "${tmpdir}/favicon.ico" 2>/dev/null; then
    if have convert; then
      convert "${tmpdir}/favicon.ico" "${tmpdir}/icon.png" 2>/dev/null || true
    fi
    if [[ -f "${tmpdir}/icon.png" ]]; then
      cp -f "${tmpdir}/icon.png" "$ICON_FILE"
      return 0
    fi
    # Best-effort fallback if no conversion available
    cp -f "${tmpdir}/favicon.ico" "$ICON_FILE" || true
    return 0
  fi

  if curl -fsSL "${base}/apple-touch-icon.png" -o "${tmpdir}/icon.png" 2>/dev/null; then
    cp -f "${tmpdir}/icon.png" "$ICON_FILE"
    return 0
  fi

  # Parse HTML for <link rel="icon"...> or <link rel="apple-touch-icon"...>
  html="$(curl -fsSL "$url" 2>/dev/null || true)"
  [[ -z "$html" ]] && return 0

  href="$(echo "$html" | tr '\n' ' ' \
    | grep -oiE '<link[^>]+rel="(apple-touch-icon|icon)"[^>]*>' \
    | head -n 1 \
    | sed -nE 's/.*href="([^"]+)".*/\1/p' || true)"

  [[ -z "$href" ]] && return 0

  icon_url="$href"
  if [[ "$icon_url" =~ ^// ]]; then
    icon_url="https:${icon_url}"
  elif [[ "$icon_url" =~ ^/ ]]; then
    icon_url="${base}${icon_url}"
  elif [[ ! "$icon_url" =~ ^https?:// ]]; then
    icon_url="${base}/${icon_url}"
  fi

  ext="$(echo "$icon_url" | sed -nE 's/.*\.([a-zA-Z0-9]+)(\?.*)?$/\1/p' | tr '[:upper:]' '[:lower:]')"
  curl -fsSL "$icon_url" -o "${tmpdir}/icon.${ext:-bin}" 2>/dev/null || true
  [[ ! -f "${tmpdir}/icon.${ext:-bin}" ]] && return 0

  # ✅ FIX: don't mix command calls inside [[ ... ]]
  if [[ "$ext" == "svg" ]] && have convert; then
    convert "${tmpdir}/icon.svg" "${tmpdir}/icon.png" 2>/dev/null || true
    [[ -f "${tmpdir}/icon.png" ]] && cp -f "${tmpdir}/icon.png" "$ICON_FILE"
  else
    cp -f "${tmpdir}/icon.${ext:-bin}" "$ICON_FILE" || true
  fi
}

download_icon "$URL" || true

# If icon download failed, use a fallback icon name
ICON_FIELD="$ICON_FILE"
if [[ ! -s "$ICON_FILE" ]]; then
  ICON_FIELD="web-browser"
fi

# -------- create desktop launcher --------
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${APP_NAME}
Comment=${APP_NAME} (app-mode launcher)
Exec=${BROWSER} --app=${URL} --class=${APP_CLASS} --user-data-dir=${USER_DATA_DIR}
Terminal=false
Icon=${ICON_FIELD}
Categories=Network;Development;
StartupWMClass=${APP_CLASS}
EOF

chmod +x "$DESKTOP_FILE"

# -------- optional: copy to Desktop (Ubuntu) --------
if [[ -d "$HOME/Desktop" ]]; then
  cp -f "$DESKTOP_FILE" "$HOME/Desktop/${APP_ID}.desktop"
  chmod +x "$HOME/Desktop/${APP_ID}.desktop"
  echo "Desktop shortcut created at: $HOME/Desktop/${APP_ID}.desktop"
  echo "Tip: Right-click it and choose 'Allow Launching' if Ubuntu prompts you."
fi

# -------- launch normal tab + app window --------
"${BROWSER}" "$URL" >/dev/null 2>&1 &
"${BROWSER}" --app="${URL}" --class="${APP_CLASS}" --user-data-dir="${USER_DATA_DIR}" >/dev/null 2>&1 &

echo "Created/updated launcher:"
echo "  $DESKTOP_FILE"
echo "App Name: $APP_NAME"
echo "URL:      $URL"
echo "Browser:  $BROWSER"
echo "Icon:     $ICON_FIELD"

