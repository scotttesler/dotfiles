function brewu() {
  brew update
  brew upgrade
  brew cleanup
  brew upgrade --cask
}

function upd() {
  local current_dir=`eval "pwd"`

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

  if ( user_has pip3 ); then
    pip3 install --upgrade pip setuptools wheel
  else
    echo "INFO: python3/pip3 not installed."
  fi

  if [[ -d "$HOME/.fzf" ]]; then
    cd ~/.fzf
    gf
  else
    echo "INFO: ~/.fzf does not exist."
  fi

  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    cd ~/.oh-my-zsh
    gf
  else
    echo "INFO: ~/.oh-my-zsh does not exist."
  fi

  updateVimPackages

  cd $current_dir
}
