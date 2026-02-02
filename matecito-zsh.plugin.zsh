# Solo en shells interactivas
[[ -o interactive ]] || return

# Opción para deshabilitar todo
[[ "$MATECITO_DISABLE" == "true" ]] && return

# =========================
# Paths del plugin
# =========================
PLUGIN_DIR="${0:A:h}"
FRASES_FILE="$PLUGIN_DIR/frases.json"

# Cache
CACHE_DIR="$HOME/.cache/matecito-zsh"
LAST_IDX_FILE="$CACHE_DIR/last_idx"
mkdir -p "$CACHE_DIR"

# =========================
# Función principal
# =========================
matecito() {
  # jq es obligatorio
  command -v jq >/dev/null || return

  TOTAL=$(jq length "$FRASES_FILE" 2>/dev/null)
  [[ -z "$TOTAL" || "$TOTAL" -eq 0 ]] && return

  IDX=$(( RANDOM % TOTAL ))

  if [[ -f "$LAST_IDX_FILE" ]]; then
    LAST_IDX=$(<"$LAST_IDX_FILE")
    while [[ "$IDX" == "$LAST_IDX" ]]; do
      IDX=$(( RANDOM % TOTAL ))
    done
  fi

  echo "$IDX" > "$LAST_IDX_FILE"

  TEXTO=$(jq -r ".[$IDX].texto" "$FRASES_FILE")
  AUTOR=$(jq -r ".[$IDX].autor" "$FRASES_FILE")

  print
  print -P "%B$TEXTO%b %F{yellow}— $AUTOR%f"
}

# =========================
# Ejecución automática
# =========================
if [[ -z "$MATECITO_SHOWN" ]]; then
  export MATECITO_SHOWN=1
  matecito
fi

alias mate=matecito
