#!/bin/bash
set -euo pipefail

# Package Linux build as tar.bz2
# Usage: ./package-linux.sh <version>

VERSION="${1:-}"

if [ -z "$VERSION" ]; then
    echo "Error: Version required"
    echo "Usage: $0 <version>"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${REPO_ROOT}/build/firefox-source"
BUILD_DIR="${REPO_ROOT}/build"

echo "Packaging FoxOne ${VERSION} for Linux..."

mkdir -p "$BUILD_DIR"

# Find the object directory
OBJ_DIR=$(find "$SOURCE_DIR" -maxdepth 1 -type d -name "obj-*" | head -1)

if [ -z "$OBJ_DIR" ]; then
    echo "Error: Object directory not found"
    exit 1
fi

DIST_DIR="${OBJ_DIR}/dist"

# Check for packaged tarball from mach package
if ls "${DIST_DIR}"/*.tar.bz2 1>/dev/null 2>&1; then
    TARBALL=$(ls "${DIST_DIR}"/*.tar.bz2 | head -1)
    cp "$TARBALL" "${BUILD_DIR}/foxone-${VERSION}-linux-x64.tar.bz2"
    echo "Copied packaged tarball"
else
    # Create tarball from dist/firefox or dist/bin
    if [ -d "${DIST_DIR}/firefox" ]; then
        PACKAGE_DIR="${DIST_DIR}/firefox"
    elif [ -d "${DIST_DIR}/bin" ]; then
        PACKAGE_DIR="${DIST_DIR}/bin"
    else
        echo "Error: Distribution directory not found"
        exit 1
    fi
    
    # Rename to foxone and create tarball
    TEMP_DIR=$(mktemp -d)
    cp -r "$PACKAGE_DIR" "${TEMP_DIR}/foxone"
    
    cd "$TEMP_DIR"
    tar -cjf "${BUILD_DIR}/foxone-${VERSION}-linux-x64.tar.bz2" foxone
    
    rm -rf "$TEMP_DIR"
fi

echo "Package created: ${BUILD_DIR}/foxone-${VERSION}-linux-x64.tar.bz2"
ls -la "${BUILD_DIR}/"
