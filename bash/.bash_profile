if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PS1="\[\033[36m\]$(gshuf -n 1 ~/.dotfiles/bash/emojis.txt)\[\033[m\]  \[\033[33;1m\]\w\[\033[m\]\[\033[36m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[m\] \$\n"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

db() {
  current_branch=`eval "git rev-parse --abbrev-ref HEAD"`

  if [ "$current_branch" == "master" ]; then
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
  git branch -d $current_branch
  git fetch --all -p
  git pull
  return 0
}

alias ber="bundle exec rake"
alias brewu="brew update && brew upgrade && brew cleanup"
alias dotfiles="cd ~/.dotfiles"
alias gf="git fetch --all -p && git pull"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gpfwl="git push --force-with-lease && yodasay 'Force pushed, you have.' | lolcatjs"
alias gri="git rebase -i origin/master"
alias gs="git status"
alias ls="ls -alGFh"
alias qf="git add . && git commit -m '.' && gri && gpfwl"
alias proj="cd ~/Documents/Projects"
alias upd="brewu && pip3 install --upgrade --user awscli pip setuptools wheel && npm i -g npm && npm update -g"
