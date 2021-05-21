export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git-scotttesler
  node-scotttesler
  updates-scotttesler
  utils-scotttesler
)

source $ZSH/oh-my-zsh.sh

# Default editor.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases.
alias dotfiles="cd ~/.dotfiles"
alias ls="ls -ahlFG"

# Prompt.
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure
PURE_PROMPT_SYMBOL=' ❯'
PROMPT='%(1j.[%j] .)%(?.%F{magenta}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '

