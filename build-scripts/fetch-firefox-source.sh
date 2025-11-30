#!/bin/bash
set -euo pipefail

# Fetch Firefox source code from Mozilla
# Usage: ./fetch-firefox-source.sh <version>

VERSION="${1:-}"

if [ -z "$VERSION" ]; then
    echo "Error: Firefox version required"
    echo "Usage: $0 <version>"
    exit 1
fi

echo "Fetching Firefox ${VERSION} source..."

# Create working directory
mkdir -p build/firefox-source
cd build/firefox-source

# Download Firefox source tarball
TARBALL_URL="https://archive.mozilla.org/pub/firefox/releases/${VERSION}/source/firefox-${VERSION}.source.tar.xz"
echo "Downloading from: ${TARBALL_URL}"

if ! wget -q --show-progress "${TARBALL_URL}" -O firefox-source.tar.xz; then
    echo "Error: Failed to download Firefox ${VERSION} source"
    exit 1
fi

echo "Extracting source..."
tar -xf firefox-source.tar.xz --strip-components=1
rm firefox-source.tar.xz

echo "Firefox ${VERSION} source fetched successfully"
