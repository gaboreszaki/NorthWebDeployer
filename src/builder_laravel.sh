#!/usr/bin/env bash
function builder() {
  cp -r "$GIT_temp_folder/$APP_build_date/" "$ACTIVE_version"

  cd "$ACTIVE_version" || exit

  fixPermissionsForLaravel

  composer install

  npm install
  npm run build

  createSymlinkForEnv

  php artisan cache:clear
  php artisan optimize
  php artisan migrate

}
