# Changelog

All notable changes to **matecito-zsh** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project follows [Semantic Versioning](https://semver.org/).

---

## [1.0.0] - 2026-02-20
### Added
- **Multilingual and Modular Support:** New directory structure to organize quotes by language and country (`phrases/es/`, `phrases/en/`).
- **Expanded Library:** Added authors from Chile, Uruguay, Colombia, Peru, Venezuela, Ecuador, Bolivia, Paraguay, USA, and UK.
- **Auto-Detection:** The plugin now automatically detects the system's language and country (via `$LANG`) to display local quotes by default.
- **Advanced Configuration:** Added `MATECITO_LANGS` and `MATECITO_COUNTRIES` environment variables for filtering or excluding specific quote libraries.

### Changed
- **Native Architecture:** Migrated all quotes from JSON to native Zsh arrays for near-instant loading.
- **Core Refactoring:** Optimized logic to load quotes only once per session, minimizing shell startup impact.

### Removed
- **Dependency-Free:** Removed `jq` dependency, eliminating the need for external tools to parse data.

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
