#!/usr/bin/env bash
function drawHeader() {

  # shellcheck disable=SC2154
  text_format="$mainTint##$tint_reset $tint_white%-54s$tint_reset $mainTint##$tint_reset\n"
  #  echo -e "$tint_red"
  printf "$mainTint#%.0s$tint_reset" {1..60}
  printf "\n"
  # shellcheck disable=SC2059
  printf "$text_format" ""
  printf "$text_format" " _____         _   _   _ _ _     _    "
  printf "$text_format" "|   | |___ ___| |_| |_| | | |___| |_"
  printf "$text_format" "| | | | . |  _|  _|   | | | | -_| . |"
  printf "$text_format" "|_|___|___|_| |_| |_|_|_____|___|___|"
  printf "$text_format" ""
  printf "$mainTint##$tint_reset $tint_white%54s$tint_reset $mainTint##$tint_reset\n" "$APP_name v$APP_version"
  printf "$mainTint#%.0s$tint_reset" {1..60}
  printf "\n\n"

}

function drawSection() {
  clear

  text_format="$mainTint#$tint_reset $tint_white%-56s$tint_reset $mainTint#$tint_reset\n"

  printf "$mainTint#%.0s$tint_reset" {1..60}
  printf '\n'
  printf "$text_format" " ____  _____ _____ __    _____ __ __ _____ _____ "
  printf "$text_format" "|    \|   __|  _  |  |  |     |  |  |   __| __  |"
  printf "$text_format" "|  |  |   __|   __|  |__|  |  |_   _|   __|    -|"
  printf "$text_format" "|____/|_____|__|  |_____|_____| |_| |_____|__|__| v$APP_version"
  printf "$text_format" ""
  printf "$mainTint#%.0s$tint_reset" {1..60}
  printf '\n'
  printf "$text_format" ""
  printf "${mainTint}# %-20s${tint_reset} ${tint_green}%-35s${tint_reset} ${mainTint}#${tint_reset} \n" "- Deployed Domain:" "$DEPLOYMENT_NAME"
  printf "${mainTint}# %-20s${tint_reset} ${tint_green}%-35s${tint_reset} ${mainTint}#${tint_reset} \n" "- Deployment Type:" "$DEPLOYMENT_TYPE"
  printf "${mainTint}# %-20s${tint_reset} ${tint_red}%-35s${tint_reset} ${mainTint}#${tint_reset} \n" "- Current Task:" "$1"
  printf "$text_format" ""
  printf "$mainTint#%.0s$tint_reset" {1..60}
  printf '\n\n'

}

function drawDescription() {
  cat "$APP_folder"/description.txt
  printf "\n"
}

function breakProcess() {

  if [ "$1" ]; then
    printf "${tint_yellow}_%.0s" {1..60}
    printf "\n\n"
    printf "$1 \n"
    printf "_%.0s" {1..60}
    printf "\n\n$tint_reset"
  fi

  printf "$(wrap_text 'Are you sure you want to continue?' red) [y/n]: \n"
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

  cd $GIT_temp_folder || exit

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
