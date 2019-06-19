function updateVimPackages() {
  current_dir=`eval "pwd"`

  cd ~/.vim/pack/packages/start

  for d in */ ; do
    cd $d
    git gc --prune=now
    git fetch --all -p
    git pull
    cd ..
  done

  cd $current_dir
}
