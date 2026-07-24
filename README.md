# 🧉 matecito-zsh

> A literary breath between commands.

Oh My Zsh plugin that uses your system locale to automatically detect your language and country. It displays quotes from local authors in your native language. Simple, offline, no noise.

## Features

- **Auto-detection** — Uses your system locale to determine your language and country.
- **Multicultural** — Modular support for multiple countries and languages (AR, CL, UY, CO, US, UK and more).
- **Native loading** — Quotes are loaded directly from `.zsh` files with minimal startup overhead.
- **No repetition** — Avoids showing the same quote twice in a row.
- **Once per session** — Runs silently in the background without visual noise.
- **Manual command** — Run `mate` or `matecito` anytime to get a new quote.

## Example

![matecito demo](demo.gif)

## Requirements

- zsh
- Oh My Zsh

### Locale

Matecito uses your system locale to automatically determine your language and country.

A properly configured locale is required for automatic detection.

Examples:

```text
LANG=es_AR.UTF-8
LANG=en_US.UTF-8
```

If your system uses the default `C` or `C.UTF-8` locale, Matecito cannot determine your language automatically. In that case, configure your system locale or edit `~/.matecitorc` manually.

## Installation

```bash
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/uvallasciani/matecito-zsh.git
```

Add it to your `~/.zshrc`:

```zsh
plugins=(... matecito-zsh)
```

Reload your shell:

```bash
exec zsh
```

## First run

On the first startup, Matecito attempts to determine your language and country using your system locale.

For example:

```text
LANG=es_AR.UTF-8  →  es / ar
LANG=en_US.UTF-8  →  en / us
```

If your system is using the default `C` or `C.UTF-8` locale, Matecito cannot determine your language automatically. Configure your system locale before the first run or edit `~/.matecitorc` manually.

> **Note:** Automatic generation of `~/.matecitorc` from the detected locale is planned for a future release.

## Configuration

Customize or override the detected settings in `~/.matecitorc`:

```zsh
MATECITO_COUNTRIES="ar,cl,py"   # specific countries
MATECITO_COUNTRIES="all"        # all available
MATECITO_COUNTRIES="all,-us"    # all except one
MATECITO_LANGS="es"             # force language
```

## Contributing

Phrases live in `phrases/<lang>/<country>.zsh` (ISO 3166-1 alpha-2 codes):

```zsh
matecito_phrases+=(
  "In the midst of winter, I found there was, within me, an invincible summer.|Albert Camus"
)
```

Guidelines:

- Keep quotes short.
- Always include the author.
- Prefer culturally relevant content.
- Follow the existing directory structure (`phrases/<lang>/<country>.zsh`).

## License

GNU General Public License v3.0
