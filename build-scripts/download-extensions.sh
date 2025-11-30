#!/bin/bash
set -euo pipefail

# Download extensions (uBlock Origin and Dark Reader)
# Run from repository root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
EXTENSIONS_DIR="${REPO_ROOT}/distribution/extensions"

echo "Downloading extensions..."

mkdir -p "$EXTENSIONS_DIR"

UBLOCK_SUCCESS=false
DARKREADER_SUCCESS=false

# Download uBlock Origin
echo "Downloading uBlock Origin..."
UBLOCK_URL="https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/addon-607454-latest.xpi"
UBLOCK_ID="uBlock0@raymondhill.net"
if wget -q --show-progress -O "${EXTENSIONS_DIR}/${UBLOCK_ID}.xpi" "$UBLOCK_URL" 2>/dev/null; then
    UBLOCK_SUCCESS=true
else
    # Fallback: try to get from GitHub releases
    echo "Primary download failed, trying GitHub releases..."
    UBLOCK_GITHUB_URL=$(curl -s https://api.github.com/repos/gorhill/uBlock/releases/latest | grep -o 'https://[^"]*firefox.xpi' | head -1 || true)
    if [ -n "$UBLOCK_GITHUB_URL" ]; then
        if wget -q --show-progress -O "${EXTENSIONS_DIR}/${UBLOCK_ID}.xpi" "$UBLOCK_GITHUB_URL" 2>/dev/null; then
            UBLOCK_SUCCESS=true
        fi
    fi
fi

if [ "$UBLOCK_SUCCESS" = true ]; then
    echo "uBlock Origin downloaded successfully"
else
    echo "Warning: Could not download uBlock Origin from any source"
fi

# Download Dark Reader
echo "Downloading Dark Reader..."
DARKREADER_URL="https://addons.mozilla.org/firefox/downloads/latest/darkreader/addon-945262-latest.xpi"
DARKREADER_ID="addon@darkreader.org"
if wget -q --show-progress -O "${EXTENSIONS_DIR}/${DARKREADER_ID}.xpi" "$DARKREADER_URL" 2>/dev/null; then
    DARKREADER_SUCCESS=true
else
    # Fallback: try to get from GitHub releases
    echo "Primary download failed, trying GitHub releases..."
    DARKREADER_GITHUB_URL=$(curl -s https://api.github.com/repos/darkreader/darkreader/releases/latest | grep -o 'https://[^"]*firefox[^"]*\.xpi' | head -1 || true)
    if [ -n "$DARKREADER_GITHUB_URL" ]; then
        if wget -q --show-progress -O "${EXTENSIONS_DIR}/${DARKREADER_ID}.xpi" "$DARKREADER_GITHUB_URL" 2>/dev/null; then
            DARKREADER_SUCCESS=true
        fi
    fi
fi

if [ "$DARKREADER_SUCCESS" = true ]; then
    echo "Dark Reader downloaded successfully"
else
    echo "Warning: Could not download Dark Reader from any source"
fi

# Verify at least one extension was downloaded
if [ "$UBLOCK_SUCCESS" = false ] && [ "$DARKREADER_SUCCESS" = false ]; then
    echo "Error: Failed to download any extensions"
    exit 1
fi

echo "Extensions downloaded to ${EXTENSIONS_DIR}"
ls -la "${EXTENSIONS_DIR}/"
