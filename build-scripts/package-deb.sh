#!/bin/bash
set -euo pipefail

# Create .deb package for FoxOne
# Usage: ./package-deb.sh <version>

VERSION="${1:-}"

if [ -z "$VERSION" ]; then
    echo "Error: Version required"
    echo "Usage: $0 <version>"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="${REPO_ROOT}/mozilla-unified"
BUILD_DIR="${REPO_ROOT}/build"

echo "Creating .deb package for FoxOne ${VERSION}..."

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

# Create deb structure
DEB_ROOT="${BUILD_DIR}/foxone-deb"
rm -rf "$DEB_ROOT"
mkdir -p "${DEB_ROOT}/DEBIAN"
mkdir -p "${DEB_ROOT}/opt/foxone"
mkdir -p "${DEB_ROOT}/usr/bin"
mkdir -p "${DEB_ROOT}/usr/share/applications"
mkdir -p "${DEB_ROOT}/usr/share/icons/hicolor/128x128/apps"

# Copy application files
cp -r "${PACKAGE_DIR}/"* "${DEB_ROOT}/opt/foxone/"

# Create symlink
ln -sf /opt/foxone/foxone "${DEB_ROOT}/usr/bin/foxone"

# Create desktop entry
cat > "${DEB_ROOT}/usr/share/applications/foxone.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Name=FoxOne
GenericName=Web Browser
Comment=Browse the World Wide Web
Exec=/opt/foxone/foxone %u
Terminal=false
Type=Application
Icon=foxone
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=foxone
EOF

# Copy icon if available
if [ -f "${PACKAGE_DIR}/browser/chrome/icons/default/default128.png" ]; then
    cp "${PACKAGE_DIR}/browser/chrome/icons/default/default128.png" "${DEB_ROOT}/usr/share/icons/hicolor/128x128/apps/foxone.png"
fi

# Create control file
cat > "${DEB_ROOT}/DEBIAN/control" << EOF
Package: foxone
Version: ${VERSION}
Section: web
Priority: optional
Architecture: amd64
Depends: libgtk-3-0 (>= 3.14), libdbus-glib-1-2 (>= 0.78), libx11-6, libxcomposite1, libxdamage1, libxext6, libxfixes3, libxrender1, libasound2, libpulse0
Maintainer: FoxOne Project <foxone@example.com>
Description: FoxOne Web Browser
 FoxOne is a customized Firefox build featuring the Firefox One theme,
 uBlock Origin, and Dark Reader extensions pre-installed.
EOF

# Create postinst script
cat > "${DEB_ROOT}/DEBIAN/postinst" << 'EOF'
#!/bin/bash
set -e
update-desktop-database -q || true
gtk-update-icon-cache -q /usr/share/icons/hicolor || true
EOF
chmod 755 "${DEB_ROOT}/DEBIAN/postinst"

# Build the .deb package
dpkg-deb --build --root-owner-group "${DEB_ROOT}" "${BUILD_DIR}/foxone-${VERSION}-linux-amd64.deb"

# Cleanup
rm -rf "$DEB_ROOT"

echo "Created: ${BUILD_DIR}/foxone-${VERSION}-linux-amd64.deb"
ls -la "${BUILD_DIR}/"*.deb
