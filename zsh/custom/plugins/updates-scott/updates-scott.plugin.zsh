function upd() {
  local current_dir=`eval "pwd"`

  brew update && brew upgrade && brew cleanup
  npm i -g npm && npm update -g
  pip3 install --upgrade pip setuptools wheel
  updateVimPackages
  cd ~/.fzf && gf

  cd $current_dir
}
