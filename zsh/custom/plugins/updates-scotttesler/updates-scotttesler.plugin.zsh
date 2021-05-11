function brewu() {
  brew update
  brew upgrade
  brew cleanup
  brew upgrade --cask
}

function upd() {
  local current_dir=$(pwd)

  if ( user_has brew ); then
    brewu
  else
    echo "INFO: brew not installed."
  fi

  if ( user_has npm ); then
    npm i -g npm
    npm update -g
  else
    echo "INFO: node/npm not installed."
  fi

  updateVimPackages

  cd $current_dir
}
