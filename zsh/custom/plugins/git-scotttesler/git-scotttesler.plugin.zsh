function db() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local default_branch=$(default_branch)

  if [[ "$current_branch" == "$default_branch" ]]; then
    echo "Current branch is $default_branch. Cannot delete $default_branch."
    return 0
  fi

  echo "Are you sure you want to delete branch $current_branch?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) break;;
      No ) return 0;;
    esac
  done

  git checkout $default_branch
  git branch -D $current_branch
  gf
}

function default_branch() {
  git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

function gd() {
  git diff $argv
}

function gf() {
  git fetch --all --prune
  git pull
}

function gl() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

function gpfwl() {
  git push --force-with-lease

  if ( user_has cowsay ); then
    if ( user_has lolcatjs ); then
      cowsay -r 'Force push (with lease)' | lolcatjs
    else
      cowsay -r 'Force push (with lease)'
    fi
  fi
}

function gri() {
  local default_branch=$(default_branch)
  git rebase -i origin/$default_branch
}

function gs() {
  git status
}

function gwip() {
  git add .
  git commit -m 'WIP'
  git push
}

function qf() {
  git add .
  git commit -m '.'
  gri
  gpfwl
}
