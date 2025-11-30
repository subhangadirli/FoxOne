# Contributing to FoxOne

Thank you for your interest in contributing to FoxOne! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help maintain a welcoming community

## How to Contribute

### Reporting Bugs

1. Check existing [issues](https://github.com/subhangadirli/FoxOne/issues) to avoid duplicates
2. Create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - System information (OS, FoxOne version)
   - Screenshots if applicable

### Suggesting Features

1. Check existing issues and discussions
2. Create a feature request issue with:
   - Clear description of the feature
   - Use case / problem it solves
   - Possible implementation approach

### Contributing Code

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test your changes (see [BUILDING.md](BUILDING.md))
5. Commit with clear messages: `git commit -m "Add feature: description"`
6. Push to your fork: `git push origin feature/your-feature`
7. Open a Pull Request

## Development Setup

See [BUILDING.md](BUILDING.md) for complete build instructions.

### Quick Start

```bash
git clone https://github.com/subhangadirli/FoxOne.git
cd FoxOne
chmod +x build-scripts/*.sh
```

## Areas for Contribution

### Branding
- Custom icons
- Splash screens
- About dialog assets

### Build Scripts
- Cross-platform compatibility
- Build optimizations
- New package formats

### Configuration
- Default preferences
- Extension selection
- Privacy enhancements

### Documentation
- Installation guides
- Troubleshooting tips
- Translations

### Theme Integration
- Theme updates
- Custom CSS improvements
- Dark/light mode support

## Coding Standards

### Shell Scripts
- Use `#!/bin/bash` shebang
- Include `set -euo pipefail` for safety
- Comment complex logic
- Use meaningful variable names

### Configuration Files
- Document all options
- Use consistent formatting
- Provide defaults where applicable

### Commit Messages
- Use imperative mood: "Add feature" not "Added feature"
- Keep first line under 72 characters
- Reference issues when applicable: "Fix #123"

## Pull Request Process

1. Update documentation if needed
2. Ensure all scripts are executable: `chmod +x *.sh`
3. Test changes on at least one platform
4. Update CHANGELOG if applicable
5. Request review from maintainers

## Testing

Before submitting:
1. Run build scripts to ensure they work
2. Test the built browser
3. Verify extensions load correctly
4. Check theme applies properly

## Release Process

FoxOne follows Firefox's release cycle:
1. Automatic weekly checks for new Firefox versions
2. Builds triggered when new version detected
3. All platforms built in parallel
4. GitHub Release created with artifacts

## License

By contributing, you agree that your contributions will be licensed under the Mozilla Public License 2.0.

## Questions?

- Open a [Discussion](https://github.com/subhangadirli/FoxOne/discussions)
- Create an [Issue](https://github.com/subhangadirli/FoxOne/issues)

Thank you for contributing to FoxOne!
