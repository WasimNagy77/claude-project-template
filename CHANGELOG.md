# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- Initial project setup from template

### Changed

### Fixed

### Security

---

## [0.0.1] - [DATE]

### Added
- Initial project structure
- Documentation framework
  - CLAUDE.md - AI assistant instructions
  - CONTRIBUTING.md - Contribution guidelines
  - SECURITY.md - Security policy
  - docs/project-context.md - Project memory
- GitHub configuration
  - Pull request template
  - Dependabot configuration
- Standard .gitignore for Node.js/Next.js

---

## Changelog Guidelines

### Categories
- **Added** - New features or functionality
- **Changed** - Changes to existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Security improvements or fixes

### When to Update
- Before each commit: Update `[Unreleased]` section
- When releasing: Move `[Unreleased]` items to new version
- Every PR: Include changelog update

### Version Format
- **Major (1.0.0)** - Breaking changes
- **Minor (0.1.0)** - New features
- **Patch (0.0.1)** - Bug fixes

### Example Entry
```markdown
## [1.2.3] - 2024-01-15

### Added
- New user authentication feature

### Fixed
- Login redirect bug

### Security
- Updated dependencies to patch CVE-2024-XXXX
```
