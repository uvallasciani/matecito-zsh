# 🧉 Matecito

> **Because every day deserves a good first line.**
>
> *Inspired by the tradition of sharing a mate and a conversation.*

Every morning I start my day with mate.

I wanted the first thing that appeared in my terminal to be something worth reading before the first command of the day.

At first, Matecito displayed quotes from Argentine authors. Later, I realized that anyone should be able to enjoy the same experience, regardless of where they live or what language they speak.

That simple idea became **Matecito**.

Matecito is a native Zsh plugin that displays quotes and thoughts from people around the world.

It is simple, works completely offline, has no external dependencies, and is designed to make the first moment in your terminal a little more special.

## Features

- 🌎 Automatic locale detection
- 🌍 Quotes from around the world
- 🔁 No repetition
- 🖐️ Manual command
- ⚡ Lightweight and native
- 📡 Completely offline
- 🔌 Framework independent

## Example

![matecito demo](demo.gif)

## Compatibility

Matecito is a native Zsh plugin and does not depend on any specific framework.

| Environment | Status |
| :---------- | :----: |
| Plain Zsh   |   ✅   |
| Oh My Zsh   |   ✅   |
| Zinit       |   ✅   |

## Installation

### Plain Zsh

Clone the repository:

```zsh
git clone https://github.com/uvallasciani/matecito-zsh.git ~/.matecito
```

Add the plugin to your `.zshrc`:

```zsh
source ~/.matecito/matecito.plugin.zsh
```

Restart your shell:

```zsh
exec zsh
```

### Oh My Zsh

Clone the repository into your custom plugins directory:

```zsh
git clone https://github.com/uvallasciani/matecito-zsh.git \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/matecito
```

Add `matecito` to the plugins list in your `.zshrc`:

```zsh
plugins=(... matecito)
```

Restart your shell:

```zsh
exec zsh
```

### Zinit

Add the following line to your `.zshrc`:

```zsh
zinit light uvallasciani/matecito-zsh
```

Restart your shell:

```zsh
exec zsh
```

## Usage

Matecito automatically displays a quote when you start a new interactive shell.

You can display another quote at any time by running:

```zsh
matecito
```

You can also use the shorter command:

```zsh
mate
```

## Localization

### System locale

Matecito relies on your operating system locale to determine which language and country should be used.

For example:

```text
LANG=es_AR.UTF-8
LANG=en_US.UTF-8
```

Automatic detection requires a properly configured system locale.

Matecito does not guess your language or your location. Instead, it follows standard Unix/Linux conventions by using your system locale as the authoritative source of information.

This keeps Matecito consistent with the rest of your shell and operating system.

If your system uses the default locale:

```text
LANG=C
```

or:

```text
LANG=C.UTF-8
```

Matecito cannot determine your preferred language automatically because these locales intentionally do not specify a language or country.

This is expected behavior.

Configure your preferred locale, for example:

```text
es_AR.UTF-8
```

or:

```text
en_US.UTF-8
```

to enable automatic language and country detection.

> **Note:** Automatic generation of `~/.matecitorc` from the detected locale is planned for a future release.

### Configuration

You can customize or override the automatically detected settings by editing:

```text
~/.matecitorc
```

For example:

```zsh
MATECITO_COUNTRIES="ar,cl,uy"
```

Limit the quote selection to specific countries.

```zsh
MATECITO_COUNTRIES="all"
```

Allow quotes from all available countries.

```zsh
MATECITO_COUNTRIES="all,-us"
```

Allow quotes from all countries except the United States.

You can also limit the languages:

```zsh
MATECITO_LANGS="es"
```

## License

Licensed under the [GNU General Public License v3.0](LICENSE).
