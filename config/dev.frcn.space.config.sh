#!/usr/bin/env bash

DEPLOYMENT_NAME="dev.frcn.space"
DEPLOYMENT_TYPE="laravel"

#todo: explain this in docs
IS_DEPLOYMENT_PRODUCTION=true ### its only reacting to false, else its gonna deploy in prod


#GIT Variables
GIT_url="https://github.com/gaboreszaki/Frontier-Consolidated.git"
GIT_branch="dev"
GIT_target_folder="/var/www/dev.frcn.space"
GIT_temp_folder="$APP_user_home_dir/deployment_temp"

ACTIVE_folder="$GIT_target_folder/active"
ACTIVE_version="$GIT_target_folder/$APP_build_date"
ACTIVE_env="$GIT_target_folder/env/.env"
