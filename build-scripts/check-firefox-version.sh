#!/bin/bash
set -euo pipefail

# Check for latest Firefox version from Mozilla
# Returns the latest stable Firefox version number

PRODUCT_DETAILS_URL="https://product-details.mozilla.org/1.0/firefox_versions.json"

# Fetch the latest version info from Mozilla
RESPONSE=$(curl -s "$PRODUCT_DETAILS_URL")

if [ -z "$RESPONSE" ]; then
    echo "Error: Failed to fetch Firefox version info" >&2
    exit 1
fi

# Extract the latest stable version
LATEST_VERSION=$(echo "$RESPONSE" | grep -o '"LATEST_FIREFOX_VERSION":"[^"]*"' | cut -d'"' -f4)

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Failed to parse Firefox version" >&2
    exit 1
fi

echo "$LATEST_VERSION"
