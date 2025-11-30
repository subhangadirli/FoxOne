#!/bin/bash
set -euo pipefail

# Create AppImage for FoxOne
# Usage: ./package-appimage.sh <version>

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

echo "Creating AppImage for FoxOne ${VERSION}..."

mkdir -p "$BUILD_DIR"

# Find the object directory
OBJ_DIR=$(find "$SOURCE_DIR" -maxdepth 1 -type d -name "obj-*" | head -1)

if [ -z "$OBJ_DIR" ]; then
    echo "Error: Object directory not found"
    exit 1
fi

DIST_DIR="${OBJ_DIR}/dist"

# Determine source directory
if [ -d "${DIST_DIR}/firefox" ]; then
    PACKAGE_DIR="${DIST_DIR}/firefox"
elif [ -d "${DIST_DIR}/bin" ]; then
    PACKAGE_DIR="${DIST_DIR}/bin"
else
    echo "Error: Distribution directory not found"
    exit 1
fi

# Download appimagetool if needed
APPIMAGETOOL="${BUILD_DIR}/appimagetool"
if [ ! -f "$APPIMAGETOOL" ]; then
    echo "Downloading appimagetool..."
    wget -q "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage" -O "$APPIMAGETOOL"
    chmod +x "$APPIMAGETOOL"
fi

# Create AppDir structure
APPDIR="${BUILD_DIR}/FoxOne.AppDir"
rm -rf "$APPDIR"
mkdir -p "${APPDIR}/usr/bin"
mkdir -p "${APPDIR}/usr/share/applications"
mkdir -p "${APPDIR}/usr/share/icons/hicolor/128x128/apps"

# Copy application files
cp -r "${PACKAGE_DIR}/"* "${APPDIR}/usr/bin/"

# Create desktop entry
cat > "${APPDIR}/foxone.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Name=FoxOne
GenericName=Web Browser
Comment=Browse the World Wide Web
Exec=foxone %u
Terminal=false
Type=Application
Icon=foxone
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;
StartupNotify=true
EOF

# Also copy to proper location
cp "${APPDIR}/foxone.desktop" "${APPDIR}/usr/share/applications/"

# Copy icon if available
if [ -f "${PACKAGE_DIR}/browser/chrome/icons/default/default128.png" ]; then
    cp "${PACKAGE_DIR}/browser/chrome/icons/default/default128.png" "${APPDIR}/foxone.png"
    cp "${PACKAGE_DIR}/browser/chrome/icons/default/default128.png" "${APPDIR}/usr/share/icons/hicolor/128x128/apps/foxone.png"
elif [ -f "${PACKAGE_DIR}/browser/chrome/icons/default/default64.png" ]; then
    # Try 64px icon as fallback
    cp "${PACKAGE_DIR}/browser/chrome/icons/default/default64.png" "${APPDIR}/foxone.png"
    cp "${PACKAGE_DIR}/browser/chrome/icons/default/default64.png" "${APPDIR}/usr/share/icons/hicolor/128x128/apps/foxone.png"
else
    # Create a simple placeholder icon using printf (no external dependencies)
    echo "Creating placeholder icon (no browser icon found)..."
    # Create a minimal 1x1 PNG as placeholder - AppImage will still work without icon
    printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xf8\xcf\xc0\x00\x00\x00\x03\x00\x01\x00\x05\xfe\xd4\x00\x00\x00\x00IEND\xaeB`\x82' > "${APPDIR}/foxone.png" || true
fi

# Create AppRun script
cat > "${APPDIR}/AppRun" << 'EOF'
#!/bin/bash
SELF=$(readlink -f "$0")
HERE=${SELF%/*}
export PATH="${HERE}/usr/bin:${PATH}"
export LD_LIBRARY_PATH="${HERE}/usr/bin:${LD_LIBRARY_PATH}"
exec "${HERE}/usr/bin/foxone" "$@"
EOF
chmod +x "${APPDIR}/AppRun"

# Make foxone executable
if [ -f "${APPDIR}/usr/bin/foxone" ]; then
    chmod +x "${APPDIR}/usr/bin/foxone"
elif [ -f "${APPDIR}/usr/bin/firefox" ]; then
    mv "${APPDIR}/usr/bin/firefox" "${APPDIR}/usr/bin/foxone"
    chmod +x "${APPDIR}/usr/bin/foxone"
fi

# Build AppImage
ARCH=x86_64 "${APPIMAGETOOL}" --no-appstream "${APPDIR}" "${BUILD_DIR}/FoxOne-${VERSION}-x86_64.AppImage"

# Cleanup
rm -rf "$APPDIR"

echo "Created: ${BUILD_DIR}/FoxOne-${VERSION}-x86_64.AppImage"
ls -la "${BUILD_DIR}/"*.AppImage
