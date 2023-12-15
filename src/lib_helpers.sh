#!/usr/bin/env bash
function drawHeader() {

  clear
  #echo "## North Web Solutions - Deployer #0.1 ##"

  echo "############################################"
  echo "##                                        ##"
  echo "##   _____         _   _   _ _ _     _    ##"
  echo "##  |   | |___ ___| |_| |_| | | |___| |_  ##"
  echo "##  | | | | . |  _|  _|   | | | | -_| . | ##"
  echo "##  |_|___|___|_| |_| |_|_|_____|___|___| ##"
  echo "##                                        ##"
  echo "############################################"
#  echo "##"
  echo "$APP_name v$APP_version"
#  echo "- $APP_company / $APP_author "
#  echo "- $APP_name #$APP_version "
#  echo "## $APP_author"
}



function drawSection() {


  clear
  echo "+----------------------------------------------------+"
  printf "| %-50s |\n" "$APP_name v$APP_version"
  printf "| %-50s |\n" ""
  printf "| %-50s |\n" "Deploying: $DEPLOYMENT_NAME "
  printf "| %-50s |\n" "Build type: $DEPLOYMENT_TYPE"
  printf "| %-50s |\n" "Task: $1"
  printf "| %-50s |\n" ""
  echo "+----------------------------------------------------+"
  printf "\n\n"

}

function drawDescription() {
  cat $APP_folder/description.txt
  printf "\n\n"
}

function breakProcess() {
  echo -n "Are you sure you want to continue? [y/n]: "
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