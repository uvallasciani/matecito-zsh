# ============================
# Matecito ZSH Plugin
# ============================
typeset -g MATECITO_LAST_INDEX=0

# ---------- Config ----------
MATECITO_CONFIG="$HOME/.matecitorc"
MATECITO_PLUGIN_DIR="${0:A:h}"
MATECITO_PHRASES_DIR="$MATECITO_PLUGIN_DIR/phrases"

# ---------- Init array ----------
typeset -ga matecito_phrases
matecito_phrases=()

# ---------- Load config ----------
load_config() {
  if [[ -f "$MATECITO_CONFIG" ]]; then
    source "$MATECITO_CONFIG"
  fi
}

# ---------- Detect system locale ----------
detect_locale() {
  local locale="${LANG:-en_US}"
  locale="${locale%%.*}"

  DETECT_LANG="${locale%%_*}"
  DETECT_COUNTRY="${locale##*_}"

  DETECT_LANG="${DETECT_LANG:l}"
  DETECT_COUNTRY="${DETECT_COUNTRY:l}"
}

# ---------- Parse CSV with exclude support ----------
parse_list() {
  local input="$1"
  local -a result
  local -a exclude

  IFS=',' read -A items <<< "$input"

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

# ---------- Resolve languages ----------
resolve_languages() {
  local -a langs

  if [[ -z "$MATECITO_LANGS" ]]; then
    langs=("$DETECT_LANG")
  elif [[ "$MATECITO_LANGS" == "all" ]]; then
    langs=("${(@f)$(ls -1 "$MATECITO_PHRASES_DIR")}")
  else
    langs=($(parse_list "$MATECITO_LANGS"))
  fi

  echo "${langs[@]}"
}

# ---------- Resolve countries ----------
resolve_countries() {
  local lang="$1"
  local -a countries

  if [[ -z "$MATECITO_COUNTRIES" ]]; then
    countries=("$DETECT_COUNTRY")
  elif [[ "$MATECITO_COUNTRIES" == "all" ]]; then
    countries=("${(@f)$(ls -1 "$MATECITO_PHRASES_DIR/$lang" 2>/dev/null | sed 's/\.zsh$//')}")
  else
    countries=($(parse_list "$MATECITO_COUNTRIES"))
  fi

  echo "${countries[@]}"
}

# ---------- Load phrase files ----------

load_phrases() {
  typeset -g matecito_phrases=()

  local langs countries
  langs=(${(s:,:)MATECITO_LANGS})
  countries=(${(s:,:)MATECITO_COUNTRIES})

  if [[ "$MATECITO_LANGS" == "all" ]]; then
    langs=($(ls "$MATECITO_PHRASES_DIR"))
  fi

  for lang in $langs; do
    [[ ! -d "$MATECITO_PHRASES_DIR/$lang" ]] && continue

    local available_countries=()
    for file in "$MATECITO_PHRASES_DIR/$lang"/*.zsh; do
      [[ -e "$file" ]] || continue
      available_countries+=("${file:t:r}")
    done

    local final_countries=()

    if [[ "$MATECITO_COUNTRIES" == "all" ]]; then
      final_countries=("${available_countries[@]}")
    else
      for c in $countries; do
        if [[ "$c" == -* ]]; then
          local exclude="${c#-}"
          available_countries=(${available_countries:#$exclude})
        else
          final_countries+=("$c")
        fi
      done

      if [[ ${#final_countries[@]} -eq 0 ]]; then
        final_countries=("${available_countries[@]}")
      fi
    fi

    for country in $final_countries; do
      local file="$MATECITO_PHRASES_DIR/$lang/$country.zsh"
      [[ -f "$file" ]] && source "$file"
    done
  done
}


# ---------- Print random ----------
matecito() {
  load_config
  detect_locale
  load_phrases

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
print "$quote — $author"
print

}

# ---------- Auto-run on shell start ----------
matecito

alias mate=matecito
