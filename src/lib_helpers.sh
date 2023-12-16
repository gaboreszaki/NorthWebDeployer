#!/usr/bin/env bash
function drawHeader() {

  printf '#%.0s' {1..60}
  printf '\n'
  printf "## %-54s ##\n" ""
  printf "## %-54s ##\n" " _____         _   _   _ _ _     _    "
  printf "## %-54s ##\n" "|   | |___ ___| |_| |_| | | |___| |_"
  printf "## %-54s ##\n" "| | | | . |  _|  _|   | | | | -_| . |"
  printf "## %-54s ##\n" "|_|___|___|_| |_| |_|_|_____|___|___|"
  printf "## %-54s ##\n" ""
  printf "## %54s ##\n" "$APP_name v$APP_version"
  printf '#%.0s' {1..60}
  printf '\n\n'

}

function drawSection() {
  clear

  printf '#%.0s' {1..60}
  printf '\n'
  printf "# %-56s #\n" " ____  _____ _____ __    _____ __ __ _____ _____ "
  printf "# %-56s #\n" "|    \|   __|  _  |  |  |     |  |  |   __| __  |"
  printf "# %-56s #\n" "|  |  |   __|   __|  |__|  |  |_   _|   __|    -|"
  printf "# %-56s #\n" "|____/|_____|__|  |_____|_____| |_| |_____|__|__| v$APP_version"
  printf "# %-56s #\n" ""
  printf "# %-56s #\n" "- Deployed Domain: $DEPLOYMENT_NAME "
  printf "# %-56s #\n" "- Deploy Type: $DEPLOYMENT_TYPE"
  printf "# %-56s #\n" "- Current Task: $1"
  printf "# %-56s #\n" ""
  printf '#%.0s' {1..60}
  printf "\n\n"

}

function drawDescription() {
  cat $APP_folder/description.txt
  printf "\n"
}

function breakProcess() {

  if [ "$1" ]; then
    printf '_%.0s' {1..60}
    printf '\n\n'
    printf "$1 \n"
    printf '_%.0s' {1..60}
    printf '\n\n'
  fi

  printf "Are you sure you want to continue? [y/n]: \n"
  read -r ans

  if [[ $ans != "y" ]]; then
    exit
  fi

}

function testFolder() {

  if [ -d "$1" ]; then
    text_result="Exists"
  else
    text_result="Created"
    mkdir -p "$1"

  fi

  echo "Directory: $text_result [$i]"
}

function checkFolders() {

  folders_list=(
    "$APP_folder"
    "$GIT_temp_folder"
    "$GIT_target_folder"
    "$APP_active_version"

  )

  for i in "${folders_list[@]}"; do

    echo "$(testFolder $i)"
  done

}

function createActiveSymlink() {

  cd $GIT_temp_folder

  echo "- Creating Symlink -"
  echo "$APP_active_version"

  ln -vfns "$ACTIVE_version" "$ACTIVE_folder"
}

function cleanup() {

  echo "Cleanup process starting in 3sec"
  sleep 3s

  rm -rfv "$GIT_temp_folder"
  printf "\n\n"
  printf "Cleanup processed"
  sleep 1s
  clear
}
