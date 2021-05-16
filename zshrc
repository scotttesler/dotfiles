export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git-scotttesler
  node-scotttesler
  updates-scotttesler
  utils-scotttesler
  vim-scotttesler
)

source $ZSH/oh-my-zsh.sh

# Default editor.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases
alias dotfiles="cd ~/.dotfiles"
alias ls="ls -ahlFG"

# Prompt
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure
