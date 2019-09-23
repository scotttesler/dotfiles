#!/usr/bin/env bash

{

function ensure_dependencies_exist() {
  if [[ ! user_has curl ]]; then
    echo "ERROR: Required dependency curl missing."
    exit 1
  elif [[ ! user_has git ]]; then
    echo "ERROR: Required dependency git missing."
    exit 1
  fi
}

function exit_if_dotfiles_dir_exists() {
  local to_dir="$HOME/dotfiles"

  if [[ -d "$to_dir" ]]; then
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

  shell_startup_file="~/.bashrc"
  if [[ "$SHELL" == *"zsh"* ]]; then
    shell_startup_file="~/.zshrc"
  fi
  source $shell_startup_file

  nvm install node
  npm i -g npm cowsay lolcatjs
}

function install_vim_start_packages() {
  cd ~/.vim/pack/packages/start

  git clone git@github.com:ctrlpvim/ctrlp.vim.git ctrlp
  git clone https://github.com/itchyny/lightline.vim lightline
  git clone git@github.com:scrooloose/nerdtree.git
  git clone git@github.com:tomtom/tcomment_vim.git tcomment
  git clone git@github.com:pangloss/vim-javascript.git
  git clone git@github.com:mxw/vim-jsx.git

  # https://github.com/prettier/vim-prettier/tree/dc1dd622c4b82ec093e8ca36c93d582d4f92fd25#install
  git clone git@github.com:prettier/vim-prettier.git prettier
  cd prettier
  npm i
}

function install_vim_opt_packages() {
  cd ~/.vim/pack/packages/opt

  git clone git@github.com:dracula/vim.git color-dracula
  git clone git@github.com:joshdick/onedark.vim.git color-one-dark
}

function setup_vim() {
  local current_dir=`eval "pwd"`
  local to_dir="$HOME/.vim"

  if [[ -d "$to_dir" ]]; then
    echo "INFO: The $to_dir directory already exists. Skipping Vim setup."
    return 0
  fi

  cp -r ./vim $to_dir
  install_vim_start_packages
  install_vim_opt_packages

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

function user_has() {
  type "$1" > /dev/null 2>&1
}

function main() {
  set -e

  ensure_dependencies_exist

  setup_zsh
  setup_node
  setup_vim

  # exit_if_dotfiles_dir_exists

  # Explain what else needs to be done manually.

  echo "Finished."
}

main

}
