function db() {
  local current_branch=`eval "git rev-parse --abbrev-ref HEAD"`

  if [[ "$current_branch" == "master" ]]; then
    echo "Current branch is master. Cannot delete master."
    return 0
  fi

  echo "Are you sure you want to delete branch $current_branch?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) break;;
      No ) return 0;;
    esac
  done

  git checkout master
  git branch -D $current_branch
  git fetch --all -p
  git pull

  return 0
}
