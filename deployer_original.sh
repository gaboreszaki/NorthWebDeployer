#!/usr/bin/env bash

#APP Variables
APP_name="Deployer"
APP_version="0.1"
APP_author="Gabor Eszaki"
APP_company="North Web Solutions"
APP_user_home_dir="/home/developer"
APP_folder="$APP_user_home_dir/deployer"
APP_build_date=$(date +%s)

#GIT Variables

GIT_url="https://github.com/gaboreszaki/CVE-frontend.git"
GIT_branch="dev"

GIT_target_folder="/var/www/cv-view"
GIT_temp_folder="$APP_user_home_dir/deployment_temp"

APP_active_folder="$GIT_target_folder/active"
APP_active_version="$GIT_target_folder/$APP_build_date"

# Same as above (alternate syntax)

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
  echo "+-------------------------------------------+"
  printf "| %-41s |\n" ""
  printf "| %-41s |\n" "$APP_name v$APP_version"
  printf "| %-41s |\n" "$1"
  printf "| %-41s |\n" ""
  echo "+-------------------------------------------+"
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
  else
    clear
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

  ln -vfns "$APP_active_version" "$APP_active_folder"
}

function getGitFiles() {

  cd "$GIT_temp_folder"
  ls -lsa
  git clone "$GIT_url" "$APP_build_date"

  cd "$APP_build_date"

  git fetch
  sleep 1s
  git checkout "$GIT_branch"
  sleep 2s

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

function buildVue() {
  cd "$GIT_temp_folder/$APP_build_date"
  npm install
  npm run build

  cd "dist"
  cp -r * "$APP_active_version"
}

##### Execute

## Headers
drawHeader
drawDescription

### Startup Process
breakProcess
drawSection "Cleanup"
cleanup

## Checklist
drawSection "Running Checklists"
checkFolders

### Get git files
drawSection "Get Files From Github"
getGitFiles

drawSection "Building Project"
buildVue

drawSection "Activating Version"
createActiveSymlink
