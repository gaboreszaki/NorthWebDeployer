#!/usr/bin/env bash
cd "$(dirname "$0")" || exit
source "autoload.sh"

if [ ! $1 ]; then
  echo "please provide the domain name for the config file"
  exit
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

function activate() {
  drawSection 'Activating Version'
  createActiveSymlink

}

function main() {
  beforeBuild
  build
  activate
}

main
