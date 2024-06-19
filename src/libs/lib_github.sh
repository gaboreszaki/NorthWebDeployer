#!/usr/bin/env bash
function getGitFiles() {

  cd "$GIT_temp_folder" || exit
  ls -lsa

  if [  $GIT_DEPLOYMENT_KEY_PATH  !=  "" ]; then
  git clone -c "core.sshCommand=ssh -i $GIT_DEPLOYMENT_KEY_PATH -F /dev/null" "$GIT_url" "$APP_build_date"
  else
  git clone "$GIT_url" "$APP_build_date"
  fi
  cd "$APP_build_date" || exit

  git fetch
  sleep 1s
  git checkout "$GIT_branch"
  sleep 2s

}

