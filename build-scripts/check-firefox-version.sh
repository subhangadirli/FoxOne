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

# Extract the latest stable version using jq if available, otherwise fallback to grep/cut
if command -v jq &> /dev/null; then
    LATEST_VERSION=$(echo "$RESPONSE" | jq -r '.LATEST_FIREFOX_VERSION // empty')
else
    # Fallback to grep/cut for environments without jq
    # This pattern matches the JSON key-value pair for LATEST_FIREFOX_VERSION
    LATEST_VERSION=$(echo "$RESPONSE" | grep -o '"LATEST_FIREFOX_VERSION":"[^"]*"' | cut -d'"' -f4)
fi

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Failed to parse Firefox version" >&2
    exit 1
fi

echo "$LATEST_VERSION"
