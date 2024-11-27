#!/usr/bin/env bash
function getGitFiles() {

  echo "Deployment Started..." > /dev/tty
  cd "$GIT_temp_folder" || exit
  #ls -lsa
  echo "Folder changed to temp folder." > /dev/tty



  if [  $GIT_DEPLOYMENT_KEY_PATH  !=  "" ]; then
  echo "Key found! Utilising identity for ssh." > /dev/tty
  echo "Cloning started from private repository." > /dev/tty

  git clone -c "core.sshCommand=ssh -F /dev/null -o IdentitiesOnly=yes -i $GIT_DEPLOYMENT_KEY_PATH " "$GIT_url" "$APP_build_date"
  else
  echo "Cloning from public repository started." > /dev/tty
  git clone "$GIT_url" "$APP_build_date"
  fi
  cd "$APP_build_date" || exit

  git fetch
  sleep 1s
  git checkout "$GIT_branch"
  sleep 2s

}

