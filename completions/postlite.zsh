if [[ ! -o interactive ]]; then
    return
fi

compctl -K _postlite postlite

_postlite() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(postlite commands)"
  else
    completions="$(postlite completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
