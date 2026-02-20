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
  # 1. Capture LANG or fallback to empty
  local locale="${LANG:-}"

  # 2. Strip encoding suffix (e.g. .UTF-8)
  local clean_locale="${locale%%.*}"

  # 3. Split language and country
  local lang_raw="${clean_locale%%_*}"
  local country_raw="${clean_locale##*_}"

  # 4. Normalize to lowercase
  DETECT_LANG="${lang_raw:l}"
  DETECT_COUNTRY="${country_raw:l}"

  # 5. Fallback to "all" if locale is invalid, unknown or malformed
  #    Triggers when:
  #    - DETECT_LANG is empty
  #    - locale is "posix"
  #    - lang code is shorter than 2 chars (e.g. "c")
  #    - lang contains non-alpha characters (e.g. "123", "??")
  #    - lang equals country but no "_" was present (e.g. LANG=C)
  if [[ -z "$DETECT_LANG" || \
        "$DETECT_LANG" == "posix" || \
        ${#DETECT_LANG} -lt 2 || \
        ! "$DETECT_LANG" =~ ^[a-z]+$ || \
        ( "$DETECT_LANG" == "$DETECT_COUNTRY" && "$clean_locale" != *_* ) ]]; then
    DETECT_LANG="all"
    DETECT_COUNTRY="all"
  fi
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

  # 1. Resolve languages
  local -a langs
  if [[ -z "$MATECITO_LANGS" || "$MATECITO_LANGS" == "all" ]]; then
    for d in "$MATECITO_PHRASES_DIR"/*(N/); do
      langs+=("${d:t}")
    done
  else
    langs=($(_matecito_parse_list "$MATECITO_LANGS"))
  fi

  # 2. Resolve countries and load phrase files
  for lang in "${langs[@]}"; do
    local lang_dir="$MATECITO_PHRASES_DIR/$lang"
    [[ ! -d "$lang_dir" ]] && continue
    local -a countries
    if [[ -z "$MATECITO_COUNTRIES" || "$MATECITO_COUNTRIES" == "all" ]]; then
      for f in "$lang_dir"/*.zsh(N.); do
        countries+=("${f:t:r}")
      done
    else
      countries=($(_matecito_parse_list "$MATECITO_COUNTRIES"))
    fi
    for country in "${countries[@]}"; do
      local file="$lang_dir/${country:l}.zsh"
      [[ -f "$file" ]] && source "$file"
    done
  done
}
_matecito_init() {
  [[ -f "$MATECITO_CONFIG" ]] && source "$MATECITO_CONFIG"
  _matecito_detect_locale
  _matecito_load_phrases
print "Plugin dir: $MATECITO_PLUGIN_DIR"
print "Phrases dir: $MATECITO_PHRASES_DIR"
print "Lang: $DETECT_LANG / Country: $DETECT_COUNTRY"
print "Phrases loaded: ${#matecito_phrases[@]}"
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
  print "\e[3;32m$quote\e[0m â€” \e[1m$author\e[0m"
}

# ---------- Auto-run ----------
_matecito_init 
matecito
alias mate=matecito
