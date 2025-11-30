#!/bin/bash
set -euo pipefail

# Setup distribution folder in Firefox build
# Run from repository root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${REPO_ROOT}/mozilla-unified"
DIST_DIR="${REPO_ROOT}/distribution"

echo "Setting up distribution folder..."

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Firefox source not found at $SOURCE_DIR"
    exit 1
fi

# Create distribution directory in source
BROWSER_DIST="${SOURCE_DIR}/browser/app/distribution"
mkdir -p "${BROWSER_DIST}/extensions"

# Copy policies.json
if [ -f "${DIST_DIR}/policies.json" ]; then
    cp "${DIST_DIR}/policies.json" "${BROWSER_DIST}/"
    echo "Copied policies.json"
fi

# Copy extensions
if [ -d "${DIST_DIR}/extensions" ]; then
    cp -r "${DIST_DIR}/extensions/"*.xpi "${BROWSER_DIST}/extensions/" 2>/dev/null || true
    echo "Copied extensions"
fi

# Copy autoconfig files
AUTOCONFIG_DIR="${REPO_ROOT}/config/autoconfig"
DEFAULTS_PREF="${SOURCE_DIR}/browser/app/defaults/pref"
DEFAULTS_DIR="${SOURCE_DIR}/browser/app/defaults"

mkdir -p "${DEFAULTS_PREF}"

if [ -f "${AUTOCONFIG_DIR}/autoconfig.js" ]; then
    cp "${AUTOCONFIG_DIR}/autoconfig.js" "${DEFAULTS_PREF}/"
    echo "Copied autoconfig.js"
fi

if [ -f "${AUTOCONFIG_DIR}/foxone.cfg" ]; then
    cp "${AUTOCONFIG_DIR}/foxone.cfg" "${DEFAULTS_DIR}/"
    echo "Copied foxone.cfg"
fi

echo "Distribution folder setup complete"
