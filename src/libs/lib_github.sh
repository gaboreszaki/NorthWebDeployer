#!/usr/bin/env bash
function getGitFiles() {

  cd "$GIT_temp_folder" || exit
  ls -lsa
  git clone "$GIT_url" "$APP_build_date"

  cd "$APP_build_date" || exit

  git fetch
  sleep 1s
  git checkout "$GIT_branch"
  sleep 2s

}

