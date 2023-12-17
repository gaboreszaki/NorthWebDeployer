#!/usr/bin/env bash
source "config.sh"
source "config/app.config.sh"
source "config/$1.config.sh"
source "src/lib_helpers.sh"
source "src/lib_github.sh"
source "src/lib_colors.sh"
source "src/builder_$DEPLOYMENT_TYPE.sh"