#!/usr/bin/env bash
source "autoload.sh"

if [ ! $1 ]; then
  echo "please provide the domain name for the config file"
  exit
fi

echo "DEPLOYMENT TYPE: $DEPLOYMENT_TYPE"

function beforeBuild() {
  ## Headers
  drawHeader
  drawDescription

  ### Startup Process
  drawSection "Cleanup"
  breakProcess
  cleanup
}

function build() {

  ## Checklist
  drawSection "Running Checklists"
  breakProcess
  checkFolders

  ### Get git files
  drawSection "Get Files From Github"
  breakProcess
  getGitFiles

  drawSection "Building Project"
  breakProcess
  builder
}

function activate() {
  drawSection "Activating Version"
  createActiveSymlink

}

function main() {
    beforeBuild
    build
    activate
}

main
