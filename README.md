# 🧉 matecito-zsh

> A literary breath between commands.

Matecito is an Oh My Zsh plugin that greets each terminal session with a quote from a local author. Quotes are automatically selected according to your system locale, providing a lightweight and completely offline experience.

## Features

- 🌎 **Automatic locale detection** — Determines your language and country from your system locale.
- 📚 **Localized quotes** — Displays literature from authors relevant to your language and region.
- 🔁 **No repetition** — Avoids showing the same quote twice in a row.
- 🚀 **Minimal startup overhead** — Loads quotes directly from native `.zsh` files.
- 🔇 **Once per session** — Runs automatically without cluttering your terminal.
- 🖐️ **Manual command** — Run `mate` or `matecito` anytime to display another quote.
- 🧩 **Modular architecture** — Easily extendable with new languages and countries.

## Example

![matecito demo](demo.gif)

---

# Installation

Clone the repository into your Oh My Zsh custom plugins directory:

```bash
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/uvallasciani/matecito-zsh.git
```

Enable the plugin in your `~/.zshrc`:

```zsh
plugins=(... matecito-zsh)
```

Reload your shell:

```bash
exec zsh
```

---

# Requirements

- zsh
- Oh My Zsh

## System locale

Matecito relies on your operating system locale to determine which language and country should be used.

For example:

```text
LANG=es_AR.UTF-8
LANG=en_US.UTF-8
```

A properly configured locale is required for automatic detection.

---

# How locale detection works

Matecito does not guess your language or your location.

Instead, it follows standard Unix/Linux conventions by using your system locale as the authoritative source of information.

This keeps Matecito consistent with the rest of your shell and operating system.

If your system uses the default locale:

```text
LANG=C
```

or

```text
LANG=C.UTF-8
```

Matecito cannot determine your preferred language automatically because those locales intentionally do not specify any language or country.

This is expected behavior.

Many minimal Linux installations and containers use `C.UTF-8` by default.

Configure your preferred locale (for example `es_AR.UTF-8` or `en_US.UTF-8`) to enable automatic language detection.

> **Note:** Automatic generation of `~/.matecitorc` from the detected locale is planned for a future release.

---

# Configuration

You can customize or override the automatically detected settings by editing:

```text
~/.matecitorc
```

Example:

```zsh
MATECITO_COUNTRIES="ar,cl,uy"
MATECITO_COUNTRIES="all"
MATECITO_COUNTRIES="all,-us"

MATECITO_LANGS="es"
```

---

# Contributing

Phrase files are organized as:

```text
phrases/
└── <language>/
    └── <country>.zsh
```

Where:

- `<language>` is an ISO 639-1 language code (`es`, `en`, `pt`, ...)
- `<country>` is an ISO 3166-1 alpha-2 country code (`ar`, `cl`, `us`, ...)

Example:

```zsh
matecito_phrases+=(
  "In the midst of winter, I found there was, within me, an invincible summer.|Albert Camus"
)
```

## Contribution guidelines

Please follow these recommendations:

- Keep quotes relatively short.
- Always include the author's name.
- Prefer literature, aphorisms, proverbs and culturally relevant quotations.
- Avoid memes, advertisements, political slogans and copyrighted song lyrics.
- Follow the existing directory structure.
- Keep the style consistent with the rest of the project.

Contributions adding new languages, countries and authors are always welcome.

---

# License

Licensed under the GNU General Public License v3.0.
