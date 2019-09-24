#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

DOTFILES_DIR="$HOME/.dotfiles"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
VIM_DIR="$HOME/.vim"

function clone_dotfiles_directory() {
  echo "Cloning the dotfiles directory to $DOTFILES_DIR ..."

  exit_if_dotfiles_dir_exists

  git clone git@github.com:scotttesler/dotfiles.git $DOTFILES_DIR
}

function copy_custom_oh_my_zsh_parts() {
  cp -R $DOTFILES_DIR/zsh/custom $OH_MY_ZSH_DIR/custom
}

function copy_github_configs() {
  cp $DOTFILES_DIR/git/gitconfig $HOME/.gitconfig
  cp $DOTFILES_DIR/git/gitignore_global $HOME/.gitignore_global
}

function copy_hyper_config() {
  cp $DOTFILES_DIR/terminals/hyper.js $HOME/.hyper.js
}

function copy_nvim_config() {
  mkdir -p $NVIM_CONFIG_DIR
  cp $DOTFILES_DIR/nvim/init.vim $NVIM_CONFIG_DIR/init.vim
}

function copy_tmux_config() {
  cp $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf
}

function ensure_dependencies_exist() {
  if ( ! user_has curl ); then
    echo "ERROR: Required dependency curl missing."
    exit 1
  elif ( ! user_has git ); then
    echo "ERROR: Required dependency git missing."
    exit 1
  fi
}

function exit_if_dotfiles_dir_exists() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "ERROR: The $DOTFILES_DIR directory already exists."
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

  local shell_startup_file="$HOME/.bashrc"
  if [[ "$SHELL" == *"zsh"* ]]; then
    shell_startup_file="$HOME/.zshrc"
  fi
  source $shell_startup_file

  nvm install node
  nvm alias default node
  npm i -g npm cowsay prettier lolcatjs
}

function install_vim_start_packages() {
  local current_dir=`eval "pwd"`

  cd $VIM_DIR/pack/packages/start

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

  cd $current_dir
}

function install_vim_opt_packages() {
  local current_dir=`eval "pwd"`

  cd $VIM_DIR/pack/packages/opt

  git clone git@github.com:dracula/vim.git color-dracula
  git clone git@github.com:joshdick/onedark.vim.git color-one-dark

  cd $current_dir
}

function setup_vim() {
  if [[ -d "$VIM_DIR" ]]; then
    echo "INFO: The $VIM_DIR directory already exists. Skipping Vim setup."
    return 0
  fi

  cp -r $DOTFILES_DIR/vim $VIM_DIR
  install_vim_start_packages
  install_vim_opt_packages
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
    copy_custom_oh_my_zsh_parts
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

  clone_dotfiles_directory
  cd $DOTFILES_DIR

  setup_zsh
  setup_node
  setup_vim

  copy_github_configs
  copy_hyper_config
  copy_nvim_config
  copy_tmux_config

  cat << MANUAL_INSTALLATION_INSTRUCTIONS
You must manually install:
- the fonts in the fonts directory
- an updated version of git
- nvim
- tmux
- Atom, VSCodium (and then copy over the settings)
- Hyper Terminal (and then copy over the settings)
MANUAL_INSTALLATION_INSTRUCTIONS

  echo ""
  echo "Finished."
}

main

}
