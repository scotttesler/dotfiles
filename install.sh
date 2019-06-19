#!/bin/bash

function exit_if_dotfiles_dir_exists() {
  to_dir=`eval "realpath ~/dotfiles"`

  if [ -d "$to_dir" ]; then
    echo "ERROR: The $to_dir directory already exists."
    echo "Exiting..."
    return 1
  fi
}

function install_zsh() {
  echo "Installing zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function setup_node() {
  echo "Installing nvm..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh)"
  # source "~/.zshrc"

  nvm install node
  npm i -g npm cowsay lolcatjs
}

function install_vim_packages() {
  cd ~/.vim/pack/packages/start

  git clone git@github.com:dracula/vim.git color-dracula
  git clone git@github.com:ctrlpvim/ctrlp.vim.git ctrlp
  git clone git@github.com:scrooloose/nerdtree.git
  git clone git@github.com:tomtom/tcomment_vim.git tcomment

  # https://github.com/prettier/vim-prettier/tree/dc1dd622c4b82ec093e8ca36c93d582d4f92fd25#install
  git clone git@github.com:prettier/vim-prettier.git prettier
  cd prettier
  npm i
}

function setup_vim() {
  current_dir=`eval "pwd"`
  to_dir=`eval "realpath ~/.vim"`

  if [ -d "$to_dir" ]; then
    echo "INFO: The $to_dir directory already exists. Skipping Vim setup."
    return 0
  fi

  cp -r ./vim $to_dir
  install_vim_packages

  cd $current_dir
}

function setup_zsh() {
  echo "Checking the current shell..."

  if [[ "$SHELL" == *"bash"* ]]; then
    echo "You are currently using bash. Would you like to install zsh?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) break;;
        No ) return 0;;
      esac
    done

    install_zsh
    return 0
  fi

  if [[ "$SHELL" == *"zsh"* ]]; then
    echo "You are currently using zsh."
    return 0
  fi
}

function main() {
  # Stop at the first non-zero exit code.
  set -e

  setup_zsh
  setup_node
  setup_vim

  # exit_if_dotfiles_dir_exists

  echo "Finished."
}

main
