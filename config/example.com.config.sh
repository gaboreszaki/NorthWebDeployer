#!/usr/bin/env bash

DEPLOYMENT_NAME="example.com" #Same as the domain to deploy and the name of the config file
DEPLOYMENT_TYPE="laravel" # Type of deployment: ['laravel', 'vue']

#todo: explain this in docs
IS_DEPLOYMENT_PRODUCTION=true #variable to set deployment characteristics


#GIT Variables
GIT_url="Your_Project_git_url" # example: "git@github.com:gaboreszaki/NorthWebDeployer.git"
GIT_branch="GIT_BRANCH" #example: "dev"
GIT_target_folder="/var/www/DESTINATION_FOLDER" #dont ad trailing slash
GIT_temp_folder="$APP_user_home_dir/deployment_temp" #Read & Write folder for temporary files

ACTIVE_folder="$GIT_target_folder/active"
ACTIVE_version="$GIT_target_folder/$APP_build_date"
ACTIVE_env="$GIT_target_folder/env/.env"


#Optional
RUNNER_AFTER=('php artisan image:process-temp') #Any inline command runnable by the deployer