# 🧉 matecito-zsh

Un plugin simple y minimalista para **Oh My Zsh** que muestra, al iniciar la terminal, una pequeña frase.

---

## ✨ Características

* 🚀 **Carga Nativa:** Las frases se cargan directamente desde scripts `.zsh`, lo que mejora el rendimiento al abrir la terminal.
* 🌎 **Multicultural:** Soporte modular para múltiples países (Argentina, Chile, Uruguay, Colombia, Perú, Venezuela, USA, UK, entre otros).
* 🧠 **Detección Automática:** El plugin identifica el idioma y país de tu sistema operativo para mostrarte frases locales por defecto.
* 🔁 **Inteligente:** Evita repetir la misma frase de forma consecutiva.
* 🧠 **Ligero:** Se ejecuta solo **una vez por sesión** para no generar ruido visual.
* ⌨️ **Comando Manual:** Accede a una frase en cualquier momento con el comando `mate` o `matecito`.

---

## 📸 Ejemplo

```
Paren el mundo, que me quiero bajar. — Quino
```

---

## 📦 Requisitos

* **zsh**
* **Oh My Zsh**

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

## ⚙️ Configuración (Opcional)

Puedes personalizar el comportamiento del plugin definiendo estas variables en tu `~/.zshrc`:

### Filtrado por Países y Lenguajes
Usa `MATECITO_LANGS` y `MATECITO_COUNTRIES` para elegir qué bibliotecas cargar.

```zsh
# Ejemplos de configuración personalizada:

# Cargar solo frases de Argentina, Chile y Paraguay
MATECITO_COUNTRIES="ar,cl,py"

# Cargar frases de todos los países disponibles
MATECITO_COUNTRIES="all"

# Cargar todos los países EXCEPTO uno específico (usa el prefijo -)
MATECITO_COUNTRIES="-us"

# Forzar el idioma español
MATECITO_LANGS="es"

---

## ☕ Uso

Automático: Al abrir una terminal nueva, se muestra una frase automáticamente.

Manual: Ejecuta `mate o matecito para ver una frase nueva en cualquier momento.

```bash
matecito
```

Alias:

```bash
mate
```

---

## 🗂️ Estructura del proyecto

```
matecito-zsh/
├── matecito-zsh.plugin.zsh
├── phrases/                  # Directorio de frases por idioma
│   ├── es/                   # Español (ar, cl, uy, co, pe, ve, ec, bo, py)
│   └── en/                   # Inglés (us, uk)
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## 📚 Frases y Contribuciones

Las frases se organizan en archivos `.zsh` por código de país (ISO 3166-1 alpha-2) dentro de `phrases/` para una carga instantánea.

### Formato de archivo (`phrases/es/ar.zsh`):

```zsh
matecito_phrases+=(
  "La duda es uno de los nombres de la inteligencia.|Jorge Luis Borges"
)
```

Se recomienda:

* Formato: Usar el separador | entre la frase y el autor.
* Extensión: Priorizar frases cortas para que luzcan bien en la terminal.
* Autoría: Indicar siempre el autor de la cita.
* Contenido: Uso cultural.

---

## 🧠 Filosofía

> **"Un respiro literario entre comandos."**

`matecito-zsh` no busca ser una herramienta de productividad, sino un pequeño ritual: acompañar el inicio de tu flujo de trabajo con una buena frase, manteniendo la terminal simple, local y sin ruido.

---

## 📚 Documentación y Cambios
* [Changelog](CHANGELOG.md) — Historial de versiones y mejoras técnicas.

---

## 📄 Licencia
Este proyecto está bajo la licencia **GNU General Public License v3.0**.

---

**¡A disfrutar de esos mates con buenas frases!** 🧉
