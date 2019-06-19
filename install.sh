#!/bin/bash

function exit_if_dotfiles_dir_exists() {
  to_dir=`eval "realpath ~/dotfiles"`

  if [ -d "$to_dir" ]; then
    echo "ERROR: The $to_dir directory already exists."
    echo "Exiting..."
    return 1
  fi

  return 0
}

function install_zsh() {
  echo "Installing zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  return 0
}

function setup_node() {
  echo "Installing nvm..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh)"
  source "~/.$SHELLrc"
}

function setup_vim() {
  to_dir=`eval "realpath ~/.vim"`

  if [ -d "$to_dir" ]; then
    echo "INFO: The $to_dir directory already exists. Skipping Vim setup."
    return 0
  fi

  cp -r ./vim $to_dir
  # Install packages.

  return 0
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
