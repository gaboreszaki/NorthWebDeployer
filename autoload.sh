#!/usr/bin/env bash
source "config.sh"
source "config/app.config.sh"
source "config/$1.config.sh"
source "src/builders/builder_$DEPLOYMENT_TYPE.sh"

## Autoload Libs
for f in src/libs/*; do
  source "$f"
done
