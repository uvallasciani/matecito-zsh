# ==============================================================================
# Matecito ZSH Plugin - v1.0.0
# ==============================================================================
typeset -g MATECITO_LAST_INDEX=0
typeset -ga matecito_phrases=()

# ---------- Configuration & Persistence ----------
MATECITO_CONFIG="$HOME/.matecitorc"
MATECITO_PLUGIN_DIR="${0:A:h}"
MATECITO_PHRASES_DIR="$MATECITO_PLUGIN_DIR/phrases"

# [Pro Tip] Auto-generate config file if missing
if [[ ! -f "$MATECITO_CONFIG" ]]; then
  cat <<'EOF' > "$MATECITO_CONFIG"
# matecito-zsh configuration
# ---------------------------------------------------------
# Set your preferred languages (e.g., "es en")
# Leave empty for auto-detection based on $LANG.
MATECITO_LANGS=""

# Set your preferred countries (e.g., "ar co uy")
# Leave empty for auto-detection. Use "all" for everything.
MATECITO_COUNTRIES=""
EOF
  print "\e[1;32mMatecito:\e[0m Configuration file created at \e[3m~/.matecitorc\e[0m "
fi

# ---------- Setup Functions ----------

_matecito_detect_locale() {
  local locale="${LANG:-en_US}"
  locale="${locale%%.*}" # Remove .UTF-8 etc.

  # Extract and force lowercase for path compatibility
  local lang_raw="${locale%%_*}"
  local country_raw="${locale##*_}"
  
  DETECT_LANG="${lang_raw:l}"
  DETECT_COUNTRY="${country_raw:l}"
}

_matecito_parse_list() {
  local input="$1"
  local -a result exclude
  local items=(${(s:,:)input})

  for item in "${items[@]}"; do
    if [[ "$item" == -* ]]; then
      exclude+=("${item#-}")
    else
      result+=("$item")
    fi
  done

  for ex in "${exclude[@]}"; do
    result=("${(@)result:#$ex}")
  done

  echo "${result[@]}"
}

_matecito_load_phrases() {
  matecito_phrases=()

  # 1. Resolve Languages
  local -a langs
  if [[ -z "$MATECITO_LANGS" ]]; then
    langs=("$DETECT_LANG")
  elif [[ "$MATECITO_LANGS" == "all" ]]; then
    langs=("$MATECITO_PHRASES_DIR"/*(/N:t))
  else
    langs=($(_matecito_parse_list "$MATECITO_LANGS"))
  fi

  # 2. Load countries per language
  for lang in "${langs[@]}"; do
    [[ ! -d "$MATECITO_PHRASES_DIR/$lang" ]] && continue

    local -a countries
    if [[ -z "$MATECITO_COUNTRIES" ]]; then
      countries=("$DETECT_COUNTRY")
    elif [[ "$MATECITO_COUNTRIES" == "all" ]]; then
      countries=("$MATECITO_PHRASES_DIR/$lang"/*.zsh(.N:t:r))
    else
      countries=($(_matecito_parse_list "$MATECITO_COUNTRIES"))
    fi

    for country in "${countries[@]}"; do
      local file="$MATECITO_PHRASES_DIR/$lang/${country:l}.zsh"
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
  # If phrases are empty (file was deleted or error), re-init
  if (( ${#matecito_phrases[@]} == 0 )) || [[ "$1" == "--reload" ]]; then
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

  print
  print "\e[3;32m$quote\e[0m — \e[1m$author\e[0m"
}

# ---------- Auto-run ----------
_matecito_init 
matecito
alias mate=matecito
