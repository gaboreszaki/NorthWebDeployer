#!/usr/bin/env bash
function createSymlinkForEnv() {
  ln -s "$ACTIVE_env" "$ACTIVE_version/.env"
}

function linkExternalStorage(){
    if [ -n "$ACTIVE_permanent_images_folder" ]; then
      echo  "No Permanent image folder detected - Activating permanent folder"
      echo  "${ACTIVE_version}/storage/app"
      echo  "${ACTIVE_permanent_images_folder}"

      # Removing current storage
      rm -rfv "${ACTIVE_version}/storage/app"
      # create symlink for storage
      ln -s "${ACTIVE_permanent_images_folder}" "${ACTIVE_version}/storage/app"
    else
      echo "No Permanent image folder detected"
    fi

}

function fixPermissionsForLaravel() {

  chgrp -R -c www-data "$ACTIVE_version"
  wait

  find "$ACTIVE_version" -type f -exec chmod 664 {} \;
  wait

  find "$ACTIVE_version" -type d -exec chmod 775 {} \;
  wait

  chgrp -R -c www-data "$ACTIVE_version/storage"
  wait

  chmod -R ug+rwx "$ACTIVE_version/storage"
  wait

  chmod -R ug+rwx "$ACTIVE_version/bootstrap/cache"
  wait

}
