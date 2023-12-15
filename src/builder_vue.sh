#!/usr/bin/env bash
function builder() {
  cd "$GIT_temp_folder/$APP_build_date"
  npm install
  npm run build


  cp -r "$GIT_temp_folder/$APP_build_date/dist" "$ACTIVE_version"
}

