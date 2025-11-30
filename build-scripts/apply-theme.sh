#!/bin/bash
set -euo pipefail

# Clone and apply Firefox One theme by Godiesc
# Run from repository root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
THEME_DIR="${REPO_ROOT}/theme"
SOURCE_DIR="${REPO_ROOT}/mozilla-unified"

echo "Cloning Firefox One theme..."

# Clone the theme repository
if [ -d "$THEME_DIR" ]; then
    echo "Theme directory exists, updating..."
    cd "$THEME_DIR"
    git pull || true
    cd "$REPO_ROOT"
else
    git clone https://github.com/Godiesc/firefox-one.git "$THEME_DIR"
fi

echo "Applying Firefox One theme..."

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Firefox source not found at $SOURCE_DIR"
    exit 1
fi

# Create chrome directory structure in the profile template
CHROME_DIR="${SOURCE_DIR}/browser/app/profile/chrome"
mkdir -p "${CHROME_DIR}"

# Copy theme files
if [ -d "${THEME_DIR}/chrome" ]; then
    cp -r "${THEME_DIR}/chrome/"* "${CHROME_DIR}/"
fi

# Copy user.js if present
if [ -f "${THEME_DIR}/user.js" ]; then
    cp "${THEME_DIR}/user.js" "${SOURCE_DIR}/browser/app/profile/"
fi

# Enable userChrome.css and userContent.css support in preferences
PREFS_FILE="${SOURCE_DIR}/browser/app/profile/firefox.js"
if [ -f "$PREFS_FILE" ]; then
    # Check if the pref already exists
    if ! grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "$PREFS_FILE"; then
        cat >> "$PREFS_FILE" << 'EOF'

// Enable custom CSS for Firefox One theme
pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
pref("svg.context-properties.content.enabled", true);
pref("layout.css.color-mix.enabled", true);
pref("layout.css.backdrop-filter.enabled", true);
pref("browser.tabs.tabClipWidth", 83);
EOF
    fi
fi

echo "Firefox One theme applied successfully"
