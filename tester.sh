#!/usr/bin/env bash
source "autoload.sh"
clear

function beforeBuild() {
  ## Headers
  drawHeader
  drawDescription

  breakProcess


  ### Startup Process
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

#beforeBuild
#build

drawSection "Cleanup"