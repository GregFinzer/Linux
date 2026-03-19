#!/usr/bin/env bash
set -euo pipefail

# InstallFromRemote
# Downloads and installs ONLY the first matching file.
# Usage:
#   InstallFromRemote "https://example.com/downloads" ".deb"
#   InstallFromRemote "https://example.com/downloads" "noble_amd64.deb"

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <url> <ends-with>"
  echo "Example: $0 \"https://example.com/downloads\" \".deb\""
  echo "Example: $0 \"https://example.com/downloads\" \"noble_amd64.deb\""
  exit 1
fi

PAGE_URL="$1"
EXT="$2"

DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"

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

ALL_LINKS="$(
  printf '%s' "$HTML" \
    | grep -Eoi 'href=["'\''][^"'\'']+["'\'']' \
    | sed -E 's/^href=["'\'']//; s/["'\'']$//' \
    | sed -E 's/[[:space:]]+//g' \
    | awk 'NF' \
    | sort -u
)"

if [[ -z "${ALL_LINKS// }" ]]; then
  echo "No links found on the page."
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

install_file() {
  local path="$1"

  if [[ "$path" == *.deb ]]; then
    echo "Installing .deb via apt: $path"
    sudo apt-get update -y >/dev/null 2>&1 || true
    sudo apt-get install -y "$path"
  else
    echo "Downloaded file is not a .deb package: $path"
    echo "No install rule for this file type."
    exit 1
  fi
}

first_match=""
first_url=""

while IFS= read -r href; do
  [[ -z "$href" ]] && continue

  full_url="$(resolve_url "$href")"
  url_no_query="${full_url%%\?*}"
  filename="$(basename "$url_no_query")"

  if [[ "$filename" == *"$EXT" ]]; then
    first_match="$filename"
    first_url="$full_url"
    break
  fi
done <<< "$ALL_LINKS"

if [[ -z "$first_url" ]]; then
  echo "No links found where filename ends with '$EXT'."
  exit 0
fi

out_path="$DOWNLOAD_DIR/$first_match"

echo "First matching file:"
echo "  $first_url"

echo "Downloading: $first_url"
curl -fL --retry 3 --retry-delay 2 -o "$out_path" "$first_url"

install_file "$out_path"

echo "Done. File saved to: $out_path"
echo "Installed file: $out_path"