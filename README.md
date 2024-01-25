```text
 _____         _   _   _ _ _     _   
|   | |___ ___| |_| |_| | | |___| |_
| | | | . |  _|  _|   | | | | -_| . |
|_|___|___|_| |_| |_|_|_____|___|___|

Deployer v0.6
```                                  
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/53ae4c1170184b909ea9f89475164ede)](https://app.codacy.com/gh/gaboreszaki/deployer/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
### What is the deployer:

The __Deployer__ is a continuous deployment(CD) pipeline tool for automate deployment in an ubuntu environment

Supported Deployment types: `Laravel`, `Vue`

> _Easy setup, Easy configuration, Zero downtime_

__In short, what it is doing?__

`checks & cleanup > git clone > change git branch > build prod > copy to destination > create symlink`


### Features:

- [x] Automatic Directory Checks and Creations
- [x] Automatic Cleanup
- [x] Git clone repo
- [x] Git select branch
- [x] Symlink generation
- [x] Custom After Build Commands
- [ ] Self Update
- [x] Rollback
- [ ] Config generator


Builders:
- [x] Laravel Build process
- [x] Vue Build process

Feature Flags:
  - [ ] Is_production
___
### Requirements:
- Ubuntu 18.04 or later
- builder requirements: 
  - composer
  - NPM
  - bash
  - compatible user on the target system

### Installation:

__Before you start the installation, we are highly recommend to create a user on your target system without sudo permissions, but with write access to the destination folder.__

After you created and logged in to the user, please follow this steps: 

1. __Get the deployer app__

   Clone the project into your user's folder on the target system. 
    ```bash
       git clone https://github.com/gaboreszaki/deployer.git
    ```
2. __Create Config files__

    Create a file called `YOUR_DOMAIN_NAME.config.sh` in the `/config` directory.
    >examples: `cv.northweb.dev.config.sh`, `example.com.config.sh`, `dev.example.com.config.sh`
 
    Template for config files: 
    ```bash
    #!/usr/bin/env bash

    DEPLOYMENT_NAME="xy.example.com" 
    DEPLOYMENT_TYPE="vue" #[vue, laravel]

    GIT_url="YOUR_GITHUB_URL" # https link for github public project
    GIT_branch="TARGET_BRANCH" # main, dev... depends on your repository
    GIT_target_folder="/var/www/YOUR_PROJECT_FOLDER" # destination for the built files (RW required)
    GIT_temp_folder="$APP_user_home_dir/deployment_temp" # temp location for create build (RW required)


    ACTIVE_folder="$GIT_target_folder/active" # symlink folder for host like Apache or Nginx 
    ACTIVE_version="$GIT_target_folder/$APP_build_date" #naming convention for the folders
    ACTIVE_env="$GIT_target_folder/env/.env" #laravel .env file location, for symlink
    
   #OPTIONAL
   RUNNER_AFTER=('php artisan xy', 'php XY_COMMAND') #Array with all items runnable after build 
   
   ```

3. Change file mode
   Change the file mod on the `deploy.sh` to be executable
   ```bash
   chmod +x deploy.sh
   ```

### Usage:
After setup, just run the `deploy` command with the deployment name,
Alternatively you can add config files to the config folder to extend the tool with new deployments.


__deploy.sh__ _[deployment_name]_ 
```bash
./deploy.sh xy.example.com
```