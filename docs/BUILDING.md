# Building FoxOne

This guide explains how to build FoxOne from source.

## Prerequisites

### All Platforms
- Git
- Mercurial (hg)
- Python 3.8+
- Node.js 16+
- Rust (latest stable)
- At least 30GB free disk space
- 8GB+ RAM recommended

### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    libgtk-3-dev \
    libdbus-glib-1-dev \
    libpulse-dev \
    libasound2-dev \
    libx11-xcb-dev \
    libxt-dev \
    nasm \
    yasm \
    zip \
    unzip \
    python3 \
    python3-pip \
    nodejs \
    npm \
    clang \
    llvm \
    lld \
    libclang-dev \
    wget \
    curl \
    git \
    mercurial \
    autoconf2.13
```

### Windows
- Install [MozillaBuild](https://ftp.mozilla.org/pub/mozilla/libraries/win32/MozillaBuildSetup-Latest.exe)
- Visual Studio 2019 or later with C++ workload

### macOS
```bash
brew install mercurial python@3.11 node yasm nasm autoconf@2.13 gnu-tar wget
```

## Install Rust and cbindgen

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup default stable
cargo install cbindgen
```

## Clone the Repository

```bash
git clone https://github.com/subhangadirli/FoxOne.git
cd FoxOne
```

## Build Steps

### 1. Fetch Firefox Source

```bash
chmod +x build-scripts/*.sh
./build-scripts/check-firefox-version.sh  # Get latest version
./build-scripts/fetch-firefox-source.sh <version>
```

### 2. Apply Customizations

```bash
./build-scripts/apply-branding.sh
./build-scripts/apply-theme.sh
./build-scripts/download-extensions.sh
./build-scripts/setup-distribution.sh
```

### 3. Configure Build

Copy the appropriate mozconfig:

```bash
# Linux
cp config/mozconfig.linux mozilla-unified/mozconfig

# macOS
cp config/mozconfig.macos mozilla-unified/mozconfig

# Windows
cp config/mozconfig.windows mozilla-unified/mozconfig
```

### 4. Build

```bash
cd mozilla-unified
./mach build
```

The build process takes 1-2 hours depending on your hardware.

### 5. Package

```bash
./mach package
```

## Creating Distribution Packages

### Linux

```bash
./build-scripts/package-linux.sh <version>  # Creates .tar.bz2
./build-scripts/package-deb.sh <version>    # Creates .deb
./build-scripts/package-appimage.sh <version>  # Creates .AppImage
```

### Windows

The `mach package` command creates a ZIP file.

### macOS

The `mach package` command creates a DMG file.

## Build Options

The mozconfig files include various build options. Key settings:

- `--enable-release`: Optimized release build
- `--enable-lto`: Link-time optimization
- `--with-branding=browser/branding/foxone`: Use FoxOne branding
- `--disable-crashreporter`: Disable crash reporting
- `--disable-telemetry`: Disable telemetry

## Troubleshooting

### Out of Memory

If the build fails with memory errors, try:
1. Close other applications
2. Add swap space
3. Reduce parallel jobs: `./mach build -j2`

### Missing Dependencies

Run bootstrap to check for missing dependencies:
```bash
cd mozilla-unified
./mach bootstrap
```

### Build Errors

1. Check the [Mozilla Build Documentation](https://firefox-source-docs.mozilla.org/setup/linux_build.html)
2. Open an issue on the FoxOne repository

## CI/CD Builds

FoxOne uses GitHub Actions for automated builds. See the workflow files:
- `.github/workflows/release.yml` - Main release orchestrator
- `.github/workflows/build-linux.yml` - Linux builds
- `.github/workflows/build-windows.yml` - Windows builds
- `.github/workflows/build-macos.yml` - macOS builds

## Directory Structure

```
FoxOne/
├── .github/workflows/    # GitHub Actions workflows
├── branding/FoxOne/      # FoxOne branding files
├── build-scripts/        # Build automation scripts
├── config/               # Build configurations
│   ├── autoconfig/       # Firefox autoconfig files
│   ├── mozconfig.linux   # Linux build config
│   ├── mozconfig.macos   # macOS build config
│   └── mozconfig.windows # Windows build config
├── distribution/         # Distribution policies and extensions
├── docs/                 # Documentation
└── mozilla-unified/      # Firefox source (created during build)
```
