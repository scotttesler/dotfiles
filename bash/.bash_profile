export PS1="\[\033[36m\]$(gshuf -n 1 ~/.dotfiles/bash/emoticons.txt)\[\033[m\] \[\033[33;1m\]\w\[\033[m\]\[\033[36m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[m\] \$\n"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias brewu="brew update && brew upgrade --all && brew cleanup"
alias dotfiles="cd ~/Documents/Projects/dotfiles"
alias gbd="git branch -d"
alias gf="git fetch --all -p"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gpfwl="git push --force-with-lease && cowsay -f dragon-and-cow 'Force pushing!!!'"
alias gri="git rebase -i origin/master"
alias ls="ls -alGFh"
alias qf="git add . && git commit -m '.' && gri && gpfwl"
alias proj="cd ~/Documents/Projects"
alias upd="brewu && pip3 install --upgrade pip setuptools wheel"
