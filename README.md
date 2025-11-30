<br />
<div align="center">
  <h1 align="center">FoxOne 🦊+</h1>

  <p align="center">
    The power of Firefox, the aesthetics of Opera One.<br>
    A modern, fluid, and fully customizable interface.
    <br />
    <br />
    <a href="https://github.com/Godiesc/firefox-one/releases"><strong>📥 Download Latest Version</strong></a>
    ·
    <a href="https://github.com/Godiesc/firefox-one/issues">Report Bug</a>
    ·
    <a href="#-Screenshots">View Screenshots</a>
  </p>
</div>

<div align="center">

[![License](https://img.shields.io/github/license/Godiesc/firefox-one?style=flat-square&color=blue)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Godiesc/firefox-one?style=flat-square&color=yellow)](https://github.com/Godiesc/firefox-one/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/Godiesc/firefox-one?style=flat-square)](https://github.com/Godiesc/firefox-one/commits/main)
[![Firefox](https://img.shields.io/badge/Firefox-115%2B-FF7139?style=flat-square&logo=firefox-browser)](https://www.mozilla.org/firefox/new/)

</div>

---
## Preview
![Preview](https://raw.githubusercontent.com/subhangadirli/FoxOne/refs/heads/main/branding/FoxOne/content/preview.png)

## Features

- **Firefox One Theme**: Beautiful, modern theme by Godiesc that transforms the browser's appearance
- **uBlock Origin**: Pre-installed and enabled by default for ad blocking and privacy protection
- **Dark Reader**: Pre-installed (disabled by default) for comfortable night-time browsing
- **Full Mozilla Account Support**: Complete sync functionality with Mozilla services
- **Privacy-Focused**: Enhanced tracking protection, HTTPS-only mode, and minimal telemetry
- **Multi-Platform**: Available for Linux, Windows, and macOS

## Downloads

Download the latest release from the [Releases](https://github.com/subhangadirli/FoxOne/releases) page.

### Available Packages

| Platform | Format | Description |
|----------|--------|-------------|
| Linux | `.tar.bz2` | Portable archive, extract and run |
| Linux | `.deb` | Debian/Ubuntu package |
| Linux | `.AppImage` | Universal Linux package |
| Windows | `.zip` | Portable archive, extract and run |
| macOS | `.dmg` | macOS disk image |

## Installation

### Linux (tar.bz2)

```bash
tar -xjf foxone-*-linux-x64.tar.bz2
cd foxone
./foxone
```

### Linux (Debian/Ubuntu)

```bash
sudo dpkg -i foxone-*-linux-amd64.deb
```

### Linux (AppImage)

```bash
chmod +x FoxOne-*.AppImage
./FoxOne-*.AppImage
```

### Windows

1. Extract the ZIP file
2. Run `foxone.exe`

### macOS

1. Open the DMG file
2. Drag FoxOne to Applications
3. Run FoxOne from Applications

## Included Extensions

### uBlock Origin
- **Status**: Enabled by default
- **Purpose**: Efficient ad blocker and privacy tool
- **Source**: [GitHub](https://github.com/gorhill/uBlock)

### Dark Reader
- **Status**: Disabled by default (enable in Add-ons)
- **Purpose**: Dark mode for websites
- **Source**: [GitHub](https://github.com/darkreader/darkreader)

## Theme

FoxOne uses the Firefox One theme by Godiesc:
- Repository: [github.com/Godiesc/firefox-one](https://github.com/Godiesc/firefox-one)
- License: Mozilla Public License 2.0

## Mozilla Account / Sync

FoxOne maintains full compatibility with Mozilla Account (formerly Firefox Sync). You can:
- Sign in with your existing Mozilla account
- Sync bookmarks, history, passwords, and settings across devices
- Use all Mozilla services

## Building from Source

See [docs/BUILDING.md](docs/BUILDING.md) for build instructions.

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for contribution guidelines.

## Automated Releases

FoxOne automatically checks for new Firefox versions weekly (Monday at midnight UTC). When a new version is detected:
1. Source code is fetched from Mozilla
2. FoxOne branding and theme are applied
3. Builds are created for all platforms
4. A new GitHub release is created

### Manual Builds

You can trigger a manual build from the GitHub Actions tab with the `force_build` option.

## Configuration

### Default Preferences

FoxOne comes with privacy-focused defaults:
- Enhanced Tracking Protection: Enabled
- HTTPS-Only Mode: Enabled
- DNS over HTTPS: Enabled
- Telemetry: Disabled
- Studies: Disabled
- Pocket: Disabled

### Customization

All Firefox customization options remain available. You can modify settings through:
- `about:preferences`
- `about:config`
- User profile `user.js`
- Custom `userChrome.css` / `userContent.css`

## License

This project is licensed under the Mozilla Public License 2.0 - see the [LICENSE](LICENSE) file for details.

Firefox and the Firefox logo are trademarks of the Mozilla Foundation.
Firefox One theme is created by Godiesc.

## Acknowledgments

- Mozilla Firefox Team
- Godiesc (Firefox One theme)
- Raymond Hill (uBlock Origin)
- Dark Reader contributors
