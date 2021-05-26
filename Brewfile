tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions" unless ENV["CODESPACES"]
tap "eth-p/software"

# CLI
brew "bat"
brew "curl"
brew "diff-so-fancy"
brew "eth-p/software/bat-extras"
brew "fzf"
brew "git"
brew "httpie"
brew "jq"
brew "neovim"
brew "pure"
brew "rbenv"
brew "rsync"
brew "the_silver_searcher"
brew "tmux"

# Fonts
cask "font-sf-mono-for-powerline"

# Applications
unless ENV["CODESPACES"]
  cask "atom-nightly"
  cask "brave-browser-nightly"
  cask "docker"
  cask "gifcapture"
  cask "gimp"
  cask "google-chrome"
  cask "jumpcut"
  cask "sequel-ace"
  cask "sizeup"
  cask "slack"
  cask "spotify"
  cask "visual-studio-code-insiders"
  cask "vlc"
  cask "zoom"
end
