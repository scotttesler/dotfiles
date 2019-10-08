function updateVimPackages() {
  local current_dir=`eval "pwd"`
  local vim_dir="$HOME/.vim"

  if [[ ! -d "$vim_dir" ]]; then
    echo "INFO: $vim_dir does not exist."
    return 0
  fi

  cd $vim_dir/pack/packages/start
  pullUpdates

  cd $vim_dir/pack/packages/opt
  pullUpdates

  cd $current_dir
}

function pullUpdates() {
  for d in */ ; do
    cd $d
    gf
    cd ..
  done
}
