## 🦊 FoxOne v0.1 - Initial Release

This is the first release of FoxOne - a customized Firefox browser with Opera One-inspired theming and pre-installed privacy extensions.

### ✨ Features

- 🎨 **Opera One Theme** - Beautiful UI powered by [Godiesc/firefox-one](https://github.com/Godiesc/firefox-one)
- 🛡️ **uBlock Origin** - Pre-installed and enabled by default
- 🌙 **Dark Reader** - Pre-installed (disabled by default)
- 🔄 **Mozilla Account** - Full Firefox Sync support
- 📦 **Independent** - Runs separately from Firefox with own profile

### 🔧 Build System

This release includes the complete build infrastructure:
- Automated weekly version checks against Mozilla Firefox releases
- Multi-platform builds (Linux, Windows, macOS)
- Automatic GitHub Releases with SHA256 checksums

### 📥 Getting Started

This is the initial project setup release. Browser binaries will be available after the first automated build.

To trigger the first build manually:
1. Go to **Actions** → **FoxOne Release**
2. Click **Run workflow**
3. Check **Force build**
4. Click **Run workflow**

The build takes 2-4 hours and will create a new release with binaries.

### 📦 Expected Release Assets (After Build)

| Platform | Files |
|----------|-------|
| Linux | `.deb`, `.AppImage`, `.tar.bz2` |
| Windows | `.zip`, `.exe` |
| macOS | `.dmg` |

### 🙏 Credits

- [Mozilla Firefox](https://www.mozilla.org/firefox/)
- [Godiesc/firefox-one](https://github.com/Godiesc/firefox-one)
- [uBlock Origin](https://github.com/gorhill/uBlock)
- [Dark Reader](https://github.com/darkreader/darkreader)

### 📄 License

MPL 2.0