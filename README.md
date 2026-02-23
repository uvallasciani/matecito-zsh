# 🧉 matecito-zsh

> A literary breath between commands.

Oh My Zsh plugin that detects your language and country to display quotes from local authors in your native language. Simple, offline, no noise.

## Features

- **Auto-detection** — Identifies your system locale to load the right quotes by default.
- **Multicultural** — Modular support for multiple countries and languages (AR, CL, UY, CO, US, UK and more).
- **Native loading** — Phrases load directly from `.zsh` scripts for instant startup.
- **No repetition** — Avoids showing the same quote twice in a row.
- **Once per session** — Runs silently in the background without visual noise.
- **Manual command** — Run `mate` or `matecito` anytime to get a new quote.

## Example

```
We are all in the gutter, but some of us are looking at the stars. — Oscar Wilde
```

## Requirements

- zsh
- Oh My Zsh

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

## Configuration

Optional settings in `~/.matecitorc`:

```zsh
MATECITO_COUNTRIES="ar,cl,py"   # specific countries
MATECITO_COUNTRIES="all"        # all available
MATECITO_COUNTRIES="all,-us"<    # all except one
MATECITO_LANGS="es"             # force language
```

## Contributing

Phrases live in `phrases/<lang>/<country>.zsh` (ISO 3166-1 alpha-2 codes):

```zsh
matecito_phrases+=(
  "In the midst of winter, I found there was, within me, an invincible summer.|Albert Camus"
)
```

Guidelines: short quotes, always include the author, culturally relevant content.

## License

GNU General Public License v3.0
