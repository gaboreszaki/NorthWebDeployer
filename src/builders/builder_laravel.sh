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
  # If $IS_DEPLOYMENT_PRODUCTION is set and its false run dev migrations
  # else run Production migrate
  if [[ $IS_DEPLOYMENT_PRODUCTION = false ]]; then
    # deploy as developer environment
    php artisan migrate:fresh --seed
  else
    # deploy as a production environment
    php artisan migrate
  fi

if [ ${#RUNNER_AFTER[@]} -eq 0 ]; then

   for i in "${RUNNER_AFTER[@]}"; do
     eval "$i"

   done
fi






}
