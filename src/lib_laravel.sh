#!/usr/bin/env bash
function createSymlinkForEnv() {
  ln -s "$ACTIVE_env" "$ACTIVE_version/.env"
}

function fixPermissionsForLaravel() {

  chgrp -R -c www-data "$ACTIVE_version"
  wait

  find "$ACTIVE_version" -type f -exec chmod 664 {} \;
  wait

  find "$ACTIVE_version" -type d -exec chmod 775 {} \;
  wait

  chgrp -R -c www-data "$ACTIVE_version/storage"
  chmod -R ug+rwx "$ACTIVE_version/storage" bootstrap/cache
  wait

}
