# ============================
# Matecito ZSH Plugin
# ============================
typeset -g MATECITO_LAST_INDEX=0
typeset -ga matecito_phrases=()

# ---------- Config ----------
MATECITO_CONFIG="$HOME/.matecitorc"
MATECITO_PLUGIN_DIR="${0:A:h}"
MATECITO_PHRASES_DIR="$MATECITO_PLUGIN_DIR/phrases"

# ---------- Setup Functions ----------
_matecito_detect_locale() {
  local locale="${LANG:-en_US}"
  locale="${locale%%.*}"

  DETECT_LANG="${${locale%%_*}#*:l}"     # Extrae idioma y pasa a minúscula
  DETECT_COUNTRY="${${locale##*_}#*:l}"  # Extrae país y pasa a minúscula
}

_matecito_parse_list() {
  local input="$1"
  local -a result exclude

  # Usamos split nativo de Zsh en lugar de cambiar el IFS
  local items=(${(s:,:)input})

  for item in "${items[@]}"; do
    if [[ "$item" == -* ]]; then
      exclude+=("${item#-}")
    else
      result+=("$item")
    fi
  done

  # Aplicar exclusiones
  for ex in "${exclude[@]}"; do
    result=("${(@)result:#$ex}")
  done

  # Devolver array como un string separado por espacios (seguro en este contexto sin espacios)
  echo "${result[@]}"
}

_matecito_load_phrases() {
  # Reiniciar arreglo por si se recarga manualmente
  matecito_phrases=()

  # 1. Resolver Idiomas
  local -a langs
  if [[ -z "$MATECITO_LANGS" ]]; then
    langs=("$DETECT_LANG")
  elif [[ "$MATECITO_LANGS" == "all" ]]; then
    # Glob nativo: Solo directorios (/), sin error si vacío (N), solo nombre (:t)
    langs=("$MATECITO_PHRASES_DIR"/*(/N:t))
  else
    langs=($(_matecito_parse_list "$MATECITO_LANGS"))
  fi

  # 2. Cargar archivos por idioma resuelto
  for lang in "${langs[@]}"; do
    [[ ! -d "$MATECITO_PHRASES_DIR/$lang" ]] && continue

    local -a countries
    if [[ -z "$MATECITO_COUNTRIES" ]]; then
      countries=("$DETECT_COUNTRY")
    elif [[ "$MATECITO_COUNTRIES" == "all" ]]; then
      # Glob nativo: Archivos regulares (.), terminados en .zsh, extraer nombre sin extensión (:t:r)
      countries=("$MATECITO_PHRASES_DIR/$lang"/*.zsh(.N:t:r))
    else
      countries=($(_matecito_parse_list "$MATECITO_COUNTRIES"))
    fi

    # Cargar archivos de los países resueltos
    for country in "${countries[@]}"; do
      local file="$MATECITO_PHRASES_DIR/$lang/$country.zsh"
      [[ -f "$file" ]] && source "$file"
    done
  done
}

_matecito_init() {
  [[ -f "$MATECITO_CONFIG" ]] && source "$MATECITO_CONFIG"
  _matecito_detect_locale
  _matecito_load_phrases
}

# ---------- Main Function ----------
matecito() {
  # Si el usuario pasa un flag de recarga, forzamos releer todo
  if [[ "$1" == "--reload" ]]; then
    _matecito_init
  fi

  (( ${#matecito_phrases[@]} == 0 )) && return

  local total=${#matecito_phrases[@]}
  local index

  if (( total == 1 )); then
    index=1
  else
    while :; do
      index=$(( RANDOM % total + 1 ))
      [[ $index -ne $MATECITO_LAST_INDEX ]] && break
    done
  fi

  MATECITO_LAST_INDEX=$index

  local entry="${matecito_phrases[$index]}"
  local quote="${entry%%|*}"
  local author="${entry##*|}"

# Salida compacta con colores
  print
  print "\e[3;32m$quote\e[0m — \e[1m$author\e[0m"
}

# ---------- Auto-run on shell start ----------
# Inicializamos silenciosamente al abrir la terminal
_matecito_init 
# Imprimimos la primera frase
matecito

alias mate=matecito
