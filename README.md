# 🧉 matecito-zsh

Un plugin simple y minimalista para **Oh My Zsh** que muestra, al iniciar la terminal, una frase corta de **autores argentinos**.

---

## ✨ Características

* 📖 Frases en español, curadas y culturales
* 🇦🇷 Autores argentinos (Borges, Cortázar, Quino, Fontanarrosa, etc.)
* ⚡ Rápido y offline (usa un archivo JSON local)
* 🔁 Evita repetir la misma frase seguida
* 🧠 Se muestra solo **una vez por sesión**
* ⌨️ Comando manual `matecito` (y alias opcional `mate`)

---

## 📸 Ejemplo

```
Paren el mundo, que me quiero bajar. — Quino
```

---

## 📦 Requisitos

* **zsh**
* **Oh My Zsh**
* **jq**

Instalar `jq`:

* Debian / Ubuntu:

  ```bash
  sudo apt install jq
  ```
* Arch:

  ```bash
  sudo pacman -S jq
  ```
* Fedora:

  ```bash
  sudo dnf install jq
  ```

---

## 🚀 Instalación

Clonar el repositorio dentro de los plugins personalizados de Oh My Zsh:

```bash
cd ~/.oh-my-zsh/custom/plugins

git clone https://github.com/uvallasciani/matecito-zsh.git
```

Editar `~/.zshrc` y agregar el plugin:

```zsh
plugins=(matecito-zsh)
```

Recargar la shell:

```bash
exec zsh
```

---

## ☕ Uso

* Al abrir una terminal nueva, se muestra una frase automáticamente.
* Para mostrar una frase manualmente:

```bash
matecito
```

Alias opcional:

```zsh
alias mate=matecito
```

---

## ⚙️ Configuración

Desactivar completamente el plugin (por ejemplo en servidores):

```zsh
export MATECITO_DISABLE=true
```

---

## 🗂️ Estructura del proyecto

```
matecito-zsh/
├── matecito-zsh.plugin.zsh
├── frases.json
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## 📚 Frases

Las frases están almacenadas en `frases.json`.

Formato:

```json
{
  "autor": "Jorge Luis Borges",
  "texto": "Siempre imaginé que el paraíso sería algún tipo de biblioteca."
}
```

Se recomienda:

* frases cortas
* siempre indicar autor
* uso cultural y no comercial

---

## 🧠 Filosofía

> Simple, local, sin ruido.

`matecito-zsh` no busca motivar ni optimizar: solo acompañar el inicio de la terminal con una buena frase.

---

## 📚 Documentación

* [Changelog](CHANGELOG.md) — historial de cambios por versión

---

## 📄 Licencia

GNU General Public License v3.0

---

🧉 Hecho en la terminal, con el mate al lado.
