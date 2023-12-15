#!/usr/bin/env bash
function builder() {
  cd "$GIT_temp_folder/$APP_build_date"
  npm install
  npm run build

  cd "dist"
  cp -r * "$APP_active_version"
}

