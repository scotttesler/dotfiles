brewu() {
  command brew update "$@"
  command brew upgrade --all "$@"
  command brew cleanup "$@"
}

gbd() { git branch -d }

gf() { git fetch --all -p }

git() {
  if [[ $@ == "log" ]]; then
    command git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
  else
    command git "$@"
  fi
}


gpfwl() {
  git push --force-with-lease
  cowsay -f dragon-and-cow 'Force pushing!!!'
}

gri() { git rebase -i origin/master }

ls() { command ls -alGFh "$@" }

qf() {
  git add .
  git commit -m '.'
  gri
  gpfwl
}

vim() {
  if hash mvim 2>/dev/null; then
    command mvim -v "$@"
  else
    command vim "$@"
  fi
}
