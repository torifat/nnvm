function nnvm() {
  if [ ! "$(command -v n)" ]; then
    echo "n is not installed!" >&2
    exit 1
  fi

  if [ -f '.nvmrc' ]; then
    local nvmrc_v=$(cat .nvmrc | tr -d v)
    local node_v=$(node -v | tr -d v)
    if [ "${nvmrc_v}" != "${node_v}" ]; then
      echo "Switching to Node v$nvmrc_v..."
      n "$nvmrc_v" >/dev/null 2>&1
      if [ $? -eq 1 ]; then
        printf "n doesn't have permission\n You can fix this with:\nsudo chown -R $(whoami) $(command -v n)"
      fi
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd nnvm
