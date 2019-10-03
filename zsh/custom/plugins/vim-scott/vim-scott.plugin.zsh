function updateVimPackages() {
  local current_dir=`eval "pwd"`

  cd ~/.vim/pack/packages/start
  pullUpdates

  cd ~/.vim/pack/packages/opt
  pullUpdates

  cd $current_dir
}

function pullUpdates() {
  for d in */ ; do
    cd $d
    git gc --prune=now
    git fetch --all -p
    git pull
    cd ..
  done
}
