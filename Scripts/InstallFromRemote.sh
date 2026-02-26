#!/usr/bin/env bash
set -euo pipefail

# InstallFromRemote
# Downloads ALL matching files, but installs ONLY the first one downloaded.
# Usage:
#   InstallFromRemote "https://example.com/downloads" ".deb"
#   InstallFromRemote "https://example.com/releases/" ".rpm"

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <url> <extension>"
  echo "Example: $0 \"https://example.com/downloads\" \".deb\""
  exit 1
fi

PAGE_URL="$1"
EXT="$2"

DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"

# Normalize extension (ensure it starts with a dot)
if [[ "$EXT" != .* ]]; then
  EXT=".$EXT"
fi

need_cmd() { command -v "$1" >/dev/null 2>&1; }

install_deps_deb() {
  if need_cmd apt-get; then
    sudo apt-get update -y
    sudo apt-get install -y curl grep sed awk coreutils
  fi
}

for c in curl grep sed awk; do
  if ! need_cmd "$c"; then
    echo "Missing required command: $c"
    echo "Attempting to install dependencies (Debian/Ubuntu/Mint)..."
    install_deps_deb
    break
  fi
done

echo "Fetching HTML from: $PAGE_URL"
HTML="$(curl -fsSL "$PAGE_URL")"

LINKS="$(
  printf '%s' "$HTML" \
    | grep -Eoi "href=[\"'][^\"']+${EXT}(\?[^\"']*)?[\"']" \
    | sed -E "s/^href=[\"']//; s/[\"']$//" \
    | sed -E 's/[[:space:]]+//g' \
    | awk 'NF' \
    | sort -u
)"

if [[ -z "${LINKS// }" ]]; then
  echo "No links ending with '$EXT' found on the page."
  exit 0
fi

SCHEME_HOST="$(printf '%s' "$PAGE_URL" | awk -F/ '{print $1"//"$3}')"
PAGE_DIR="$PAGE_URL"
if [[ "$PAGE_DIR" != */ ]]; then
  PAGE_DIR="$(dirname "$PAGE_DIR")/"
fi

resolve_url() {
  local href="$1"
  if [[ "$href" =~ ^https?:// ]]; then
    printf '%s' "$href"
  elif [[ "$href" =~ ^// ]]; then
    local scheme
    scheme="$(printf '%s' "$PAGE_URL" | awk -F: '{print $1}')"
    printf '%s' "${scheme}:${href}"
  elif [[ "$href" =~ ^/ ]]; then
    printf '%s' "${SCHEME_HOST}${href}"
  else
    printf '%s' "${PAGE_DIR}${href}"
  fi
}

install_file_if_supported() {
  local path="$1"

  if [[ "$path" == *.deb ]]; then
    echo "Installing .deb via apt: $path"
    sudo apt-get update -y >/dev/null 2>&1 || true
    sudo apt-get install -y "$path"
  elif [[ "$path" == *.rpm ]]; then
    echo "Installing .rpm via rpm: $path"
    if ! need_cmd rpm; then
      echo "rpm is not installed. On Debian/Ubuntu/Mint you can: sudo apt-get install -y rpm"
      exit 1
    fi
    sudo rpm -Uvh --replacepkgs "$path"
  else
    echo "No install rule for: $path"
  fi
}

echo "Found the following matching links:"
echo "$LINKS" | sed 's/^/  - /'

installed=false
first_installed_path=""

while IFS= read -r href; do
  [[ -z "$href" ]] && continue

  full_url="$(resolve_url "$href")"

  # Determine output file name (strip query string)
  url_no_query="${full_url%%\?*}"
  filename="$(basename "$url_no_query")"
  out_path="$DOWNLOAD_DIR/$filename"

  echo "Downloading: $full_url"
  curl -fL --retry 3 --retry-delay 2 -o "$out_path" "$full_url"

  # Only install the first downloaded file
  if [[ "$installed" == false ]]; then
    install_file_if_supported "$out_path"
    installed=true
    first_installed_path="$out_path"
  fi
done <<< "$LINKS"

echo "Done. Files saved to: $DOWNLOAD_DIR"
if [[ "$installed" == true ]]; then
  echo "Installed only the first downloaded file: $first_installed_path"
else
  echo "No file was installed."
fi
