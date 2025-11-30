#!/bin/bash
set -euo pipefail

# Apply FoxOne branding to Firefox source
# Run from repository root after fetching Firefox source

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${PROJECT_ROOT}/build/firefox-source"
BRANDING_SRC="${PROJECT_ROOT}/branding/FoxOne"
BRANDING_DEST="${SOURCE_DIR}/browser/branding/FoxOne"

echo "Applying FoxOne branding..."

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Firefox source not found at $SOURCE_DIR"
    exit 1
fi

mkdir -p "$BRANDING_DEST"
cp -r "${BRANDING_SRC}/"* "$BRANDING_DEST/" || true

# Update confvars.sh if it exists
if [[ -f "${SOURCE_DIR}/browser/confvars.sh" ]]; then
    sed -i.bak 's/MOZ_APP_NAME=firefox/MOZ_APP_NAME=foxone/g' "${SOURCE_DIR}/browser/confvars.sh" || true
    sed -i.bak 's/MOZ_APP_DISPLAYNAME=Firefox/MOZ_APP_DISPLAYNAME=FoxOne/g' "${SOURCE_DIR}/browser/confvars.sh" || true
fi

echo "Branding applied successfully"
