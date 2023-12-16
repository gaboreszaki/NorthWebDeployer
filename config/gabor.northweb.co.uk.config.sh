#!/usr/bin/env bash

DEPLOYMENT_NAME="gabor.northweb.co.uk"
DEPLOYMENT_TYPE="vue"

#GIT Variables
GIT_url="https://github.com/gaboreszaki/CVE-frontend.git"
GIT_branch="main"
GIT_target_folder="/var/www/gabor.northweb.co.uk"
GIT_temp_folder="$APP_user_home_dir/deployment_temp"


ACTIVE_folder="$GIT_target_folder/active"
ACTIVE_version="$GIT_target_folder/$APP_build_date"

