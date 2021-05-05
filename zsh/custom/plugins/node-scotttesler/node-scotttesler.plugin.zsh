function install_latest_node() {
  if ( ! user_has nvm ); then
    echo "ERROR: Required dependency nvm missing."
    exit 1
  fi

  local current_node=$(nvm current)

  nvm install node
  nvm alias default node
  nvm uninstall $current_node
  npm i -g cowsay diff-so-fancy lolcatjs npm prettier pure-prompt spaceship-prompt
}
