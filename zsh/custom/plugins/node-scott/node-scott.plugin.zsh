function install_latest_node() {
  local current_node=`eval "node -v"`

  if ( ! user_has nvm ); then
    echo "ERROR: Required dependency nvm missing."
    exit 1
  fi

  nvm install node
  nvm alias default node
  nvm uninstall $current_node
  npm i -g npm prettier cowsay lolcatjs

  return 0
}

function user_has() {
  type "$1" > /dev/null 2>&1
}
