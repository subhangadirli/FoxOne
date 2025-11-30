#!/bin/bash
set -euo pipefail

# Main Linux build script for FoxOne
# Run from repository root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${REPO_ROOT}/build/firefox-source"

echo "Building FoxOne for Linux..."

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Firefox source not found at $SOURCE_DIR"
    exit 1
fi

# Ensure Rust is available
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

cd "$SOURCE_DIR"

# Bootstrap if needed
if [ ! -f ".mozconfig" ] && [ ! -f "mozconfig" ]; then
    echo "No mozconfig found, copying from config..."
    cp "${REPO_ROOT}/config/mozconfig.linux" mozconfig
fi

# Run the build
echo "Starting mach build..."
./mach build

echo "Build complete!"

# Package the build
echo "Packaging..."
./mach package

echo "FoxOne Linux build completed successfully"
