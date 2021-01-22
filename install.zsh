#! /usr/bin/env zsh

{ # this ensures the entire script is downloaded #

DOTFILES_DIR="$HOME/.dotfiles"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
VIM_DIR="$HOME/.vim"

function clone_dotfiles_directory() {
  echo "Cloning the dotfiles directory to $DOTFILES_DIR ..."

  exit_if_dotfiles_dir_exists

  git clone https://github.com/scotttesler/dotfiles.git "$DOTFILES_DIR"
}

function copy_custom_oh_my_zsh_parts() {
  echo "Copying custom zshrc and plugins ..."
  cp "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
  rsync -ah "$DOTFILES_DIR/zsh/custom/" "$OH_MY_ZSH_DIR/custom"
}

function copy_github_configs() {
  cp "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
  cp "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
}

function copy_nvim_config() {
  mkdir -p "$NVIM_CONFIG_DIR"
  cp "$DOTFILES_DIR/nvim/init.vim" "$NVIM_CONFIG_DIR/init.vim"
}

function copy_tmux_config() {
  cp "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
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

function install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  yes | "$HOME/.fzf/install"

  # shellcheck source=/dev/null
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

function install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  copy_custom_oh_my_zsh_parts
}

function install_node() {
  echo "Installing nvm..."
  sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh)"

  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  export NVM_DIR

  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install node
  nvm alias default node
  npm i -g cowsay lolcatjs npm prettier spaceship-prompt
}

function install_vim_start_packages() {
  local current_dir
  current_dir=$(pwd)

  cd "$VIM_DIR/pack/packages/start"

  git clone https://github.com/mileszs/ack.vim.git ack
  git clone https://github.com/ryanoasis/vim-devicons.git dev-icons
  git clone https://github.com/itchyny/lightline.vim lightline
  git clone https://github.com/scrooloose/nerdtree.git
  git clone https://github.com/tomtom/tcomment_vim.git tcomment
  git clone https://github.com/pangloss/vim-javascript.git javascript
  git clone https://github.com/MaxMEllon/vim-jsx-pretty.git jsx-pretty

  # https://github.com/prettier/vim-prettier/tree/dc1dd622c4b82ec093e8ca36c93d582d4f92fd25#install
  git clone https://github.com/prettier/vim-prettier.git prettier
  cd prettier
  npm i

  cd "$current_dir"
}

function install_vim_opt_packages() {
  local current_dir
  current_dir=$(pwd)

  cd "$VIM_DIR/pack/packages/opt"

  git clone https://github.com/dracula/vim.git color-dracula
  git clone https://github.com/joshdick/onedark.vim.git color-one-dark

  cd "$current_dir"
}

function setup_vim() {
  if [[ -d "$VIM_DIR" ]]; then
    echo "INFO: The $VIM_DIR directory already exists. Skipping Vim setup."
    return 0
  fi

  cp -R "$DOTFILES_DIR/vim" "$VIM_DIR"
  install_vim_start_packages
  install_vim_opt_packages
}

function user_has() {
  type "$1" > /dev/null 2>&1
}

function main() {
  set -e

  ensure_dependencies_exist

  clone_dotfiles_directory
  cd "$DOTFILES_DIR"

  install_oh_my_zsh
  install_node
  install_fzf
  setup_vim

  copy_github_configs
  copy_nvim_config
  copy_tmux_config

  cat << MANUAL_INSTALLATION_INSTRUCTIONS
You must manually install:
- an updated version of git
- nvim
- tmux
- Atom, VSCodium (and then copy over the settings)
MANUAL_INSTALLATION_INSTRUCTIONS

  echo ""
  echo "Finished."
}

main

}
