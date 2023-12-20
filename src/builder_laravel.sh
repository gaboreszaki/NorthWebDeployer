#!/usr/bin/env bash
function builder() {
  # Copy files to the destination
  cp -r "$GIT_temp_folder/$APP_build_date/" "$ACTIVE_version"

  cd "$ACTIVE_version" || exit

  # Build dependencies
  composer install

  npm install
  npm run build



  #Creating Symlinks for .env and public storage
  php artisan storage:link
  createSymlinkForEnv

  fixPermissionsForLaravel

  php artisan cache:clear
  php artisan optimize
  php artisan migrate

}
