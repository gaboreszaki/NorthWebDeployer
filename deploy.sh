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
  breakProcess
  drawSection "Cleanup"
  cleanup
}

function build() {

  ## Checklist
  drawSection "Running Checklists"
  checkFolders

  ### Get git files
  drawSection "Get Files From Github"
  getGitFiles

  drawSection "Building Project"
  builder
}

function activate() {
  drawSection "Activating Version"
  createActiveSymlink
}

function run() {
    beforeBuild
    build
    activate
}

run
