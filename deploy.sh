#!/usr/bin/env bash

cd "$(dirname "$0")" || exit


if [ ! $1 ]; then
  echo "please provide the domain name for the config file"
  exit
else
  source "autoload.sh"
  #extacting data for Rollback #1 domain - #2 timestamp
  extractDataForRollback "$1" "$APP_build_date"


fi

function beforeBuild() {
  clear

  ## Headers
  drawHeader
  drawDescription
  #  breakProcess 'Warning, this will remove the contents of the TEMP folder'

  ### Startup Process
  drawSection 'Cleanup process'
  cleanup
}

function build() {

  ## Checklist
  drawSection 'Running Checklists'
  checkFolders

  ### Get git files
  drawSection 'Get Files From Github'
  getGitFiles

  drawSection 'Building Project'
  builder
}

function afterBuild() {
  if [ ${#RUNNER_AFTER[@]} -eq 0 ]; then
    return
  else
    for i in "${RUNNER_AFTER[@]}"; do
      eval "$i"
    done
  fi
}

function activate() {
  drawSection 'Activating Version'

  createActiveSymlink

}

function main() {
  beforeBuild
  build
  afterBuild
  activate
}

main
