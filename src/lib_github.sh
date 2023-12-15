#!/usr/bin/env bash
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

