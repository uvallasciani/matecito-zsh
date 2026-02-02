# Changelog

All notable changes to **matecito-zsh** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project follows [Semantic Versioning](https://semver.org/).

---

## [0.1.2] - 2026-02-02
### Fixed
- Reliable plugin directory detection in Oh My Zsh
- Fixed syntax errors in frases.json

---

## [v0.1.1] - 2026-02-02
### Fixed
- Improved plugin path resolution to ensure `frases.json` is always found
- More robust handling of interactive shells and SSH sessions

---

## [v0.1.0] - 2026-01-30
### Added
- Initial public release
- Display a random quote from Argentine authors on shell startup
- Manual `matecito` command and optional `mate` alias
- Local JSON storage, offline usage
- Cache to avoid repeating the last quote
- Runs only once per session
