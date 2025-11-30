#!/bin/bash
set -euo pipefail

# Apply FoxOne branding to Firefox source
# Run from repository root after fetching Firefox source

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${REPO_ROOT}/mozilla-unified"

echo "Applying FoxOne branding..."

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Firefox source not found at $SOURCE_DIR"
    exit 1
fi

# Create branding directory in source
BRANDING_DIR="${SOURCE_DIR}/browser/branding/foxone"
mkdir -p "${BRANDING_DIR}"

# Copy branding files
cp -r "${REPO_ROOT}/branding/FoxOne/"* "${BRANDING_DIR}/"

# Update configure.sh to use foxone branding
if [ -f "${SOURCE_DIR}/browser/confvars.sh" ]; then
    sed -i 's/MOZ_BRANDING_DIRECTORY=.*/MOZ_BRANDING_DIRECTORY=browser\/branding\/foxone/' "${SOURCE_DIR}/browser/confvars.sh"
fi

# Update application.ini template if exists
APP_INI="${SOURCE_DIR}/browser/app/profile/firefox.js"
if [ -f "$APP_INI" ]; then
    # Add FoxOne specific preferences
    cat >> "$APP_INI" << 'EOF'

// FoxOne Preferences
pref("browser.startup.homepage", "about:home");
pref("browser.newtabpage.enabled", true);
pref("browser.newtabpage.activity-stream.feeds.topsites", true);
pref("browser.newtabpage.activity-stream.showSearch", true);
EOF
fi

# Copy autoconfig files to defaults
DEFAULTS_DIR="${SOURCE_DIR}/browser/app/profile"
mkdir -p "${DEFAULTS_DIR}"

if [ -f "${REPO_ROOT}/config/autoconfig/autoconfig.js" ]; then
    cp "${REPO_ROOT}/config/autoconfig/autoconfig.js" "${DEFAULTS_DIR}/"
fi

echo "FoxOne branding applied successfully"
