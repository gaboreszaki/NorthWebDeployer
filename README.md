```text
 _____         _   _   _ _ _     _   
|   | |___ ___| |_| |_| | | |___| |_
| | | | . |  _|  _|   | | | | -_| . |
|_|___|___|_| |_| |_|_|_____|___|___|

North Web Deployer v0.7
```                                  

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/53ae4c1170184b909ea9f89475164ede)](https://app.codacy.com/gh/gaboreszaki/deployer/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

### What is the 'North Web Deployer':

The __NWD__ is a continuous deployment(CD) pipeline tool for automate build & deployment in Ubuntu-server & Apache2 environment.
This application is utilizing symlinks to achive Zero-Downtime.

Supported Deployment types: `Laravel`, `Vue`

> _Easy setup, Easy configuration, Zero downtime_

__In short, what it is doing?__

`checks & cleanup > git clone > change git branch > build prod > copy to destination > create symlink`

### Features:

- [x] Automatic Directory Checks and Creations
- [x] Automatic Cleanup
- [x] Git clone repo (public & private)
- [x] Git select branch
- [x] Symlink generation
- [x] Custom 'After Build' Commands
- [x] Rollback
- [x] Optional - Persistent Images
- [ ] Self Update
- [ ] Config generator

Builders:

- [x] Laravel Build process
- [x] Vue Build process

Feature Flags:

- [ ] Is_production

___

### Requirements:

- Ubuntu 18.04 or later
- Builder requirements:
    - User on the target system with access to the targeted repository.
    - Composer
    - NPM
    - Bash

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
   > examples: `cv.northweb.dev.config.sh`, `example.com.config.sh`, `dev.example.com.config.sh`

   Template for config files:
    ```bash
    #!/usr/bin/env bash

    DEPLOYMENT_NAME="xy.example.com" 
    DEPLOYMENT_TYPE="vue" #[vue, laravel]

    GIT_url="YOUR_GITHUB_URL" # SSL link for github public project like: "git@github.com:gaboreszaki/NorthWebDeployer.git"
    GIT_branch="TARGET_BRANCH" # main, dev... depends on your repository
    GIT_target_folder="/var/www/YOUR_PROJECT_FOLDER" # destination for the built files (RW required)
    GIT_temp_folder="$APP_user_home_dir/deployment_temp" # temp location for create build (RW required)


    ACTIVE_folder="$GIT_target_folder/active" # symlink folder for host like Apache or Nginx 
    ACTIVE_version="$GIT_target_folder/$APP_build_date" #naming convention for the folders
    ACTIVE_env="$GIT_target_folder/env/.env" #laravel .env file location, for symlink
   
    
   #OPTIONAL
   ACTIVE_permanent_images_folder="$GIT_target_folder/ext_storage"
   $GIT_DEPLOYMENT_KEY_PATH="/home/user/.ssh/id_rsa"
   
   
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

## How to Deploy from private repository:

Requirements: **v0.7 or higher**

### Steps:

#### Create a private key on your server
``` bash
ssh-keygen -t rsa -b 4096 -C "deploy-key-for-xy-project@myserver.xy" -f ~/.ssh/xy-project
```
> Important: Don't add  a passphrase.



Add to GitHub as a deploy key:
Go to your repository -> settings -> deployment keys.

Here press 'add deploy key', a form will open.

add a name, and from your terminal copy the results of this command to the key input :

```bash
cat ~/.ssh/xy-project.pub
```
or just copy the content of your public file into the key form imput.

> NOTE: It is very important to protect this key, and you only share the `.pub` of your key pair.

## Add your key path to the config file:

```bash 
GIT_DEPLOYMENT_KEY_PATH="~/.ssh/xy-project"
```

To verify the changes you should run de deployment as normal, but in therminal you sould be able to see the following: "Key found! Utilising identity for ssh." and "Cloning started from private repository"

## Breaking changes:
v0.7 - git url in the config must be an ssh 

# Github Actions
## Steps to create the CD pipeline:
- Install/clone deployer to your server (read above)
- Create config files (read above)
- Create environment on GitHub (repository settings)
- Add workflow files to your source-code


## Environment - Secrets and variables

(` Repository > Settings > Secrets & variables > actions`)

Create a new environment:

1. Name your environment (like prod, dev, etc)
2. (optional) select deployment protection rules
3. select branch and tags, i recommend to "selected branches and tags" and choose like main branch for prod environment
4. add environment secrets & variables:

**Secrets**:
`SSH_HOST` = "yourdomin.com" this is the domain or ip where you are hosting your website
`SSH_PORT` = "22" or your SSH port
`SSH_USER` = "Username" the "deployer" user with access to write in the destination directory
`SSH_KEY` = "RSA KEY (private) " - Make sure you generate a dedicated key for deployment, and register the public key with the user in your  `~/.ssh/authorized_keys`

**Variables**:
`TARGET_DOMAIN` = "your.domain.com" this is the identification for triggering the deployer.
the workflow will run the `cd deployer && ./deploy.sh ${{ vars.TARGET_DOMAIN }}` command

# Workflow file

Change the name / run-name / branches and the environment to match with your settings / your likings

> `environment:` environment's name in your repo settings (like prod, dev, etc)
> make sure its an exact match!

### Production example : ( `.github/workflows/production.yaml` )

``` yaml
name: Production
run-name: ${{ github.actor }} deploying ${{ vars.TARGET_DOMAIN }} to production
on:
  push:
    branches:
      - main
jobs:
  deploy:
    environment: ***YOUR_ENVIROMENT_NAME***
    name: "Triggering Remote Deployer"
    runs-on: ubuntu-latest
    # needs: test
    steps:
      - name: Configure SSH
        run: |
          mkdir -p ~/.ssh/
          echo "$SSH_KEY" > ~/.ssh/staging.key
          cat ~/.ssh/staging.key
          chmod 600 ~/.ssh/staging.key
          cat >>~/.ssh/config <<END
          Host staging
            HostName $SSH_HOST
            User $SSH_USER
            Port $SSH_PORT
            IdentityFile ~/.ssh/staging.key
            StrictHostKeyChecking no
          END
        env:
          SSH_USER: ${{ secrets.SSH_USER }}
          SSH_KEY: ${{ secrets.SSH_KEY }}
          SSH_HOST: ${{ secrets.SSH_HOST }}
          SSH_PORT: ${{ secrets.SSH_PORT }}

      - name: Check out the source
        run: ssh staging "cd deployer && ./deploy.sh ${{ vars.TARGET_DOMAIN }}"



```

### Development example : ( `.github/workflows/development.yaml` )

``` yaml
name: Development
run-name: ${{ github.actor }} deploying ${{ vars.TARGET_DOMAIN }} to development
on:
  push:
    branches:
      - dev
jobs:
  deploy:
    environment: (dev) gabor.northweb.dev
    name: "Triggering Remote Deployer"
    runs-on: ubuntu-latest
    # needs: test
    steps:
      - name: Configure SSH
        run: |
          mkdir -p ~/.ssh/
          echo "$SSH_KEY" > ~/.ssh/staging.key
          cat ~/.ssh/staging.key
          chmod 600 ~/.ssh/staging.key
          cat >>~/.ssh/config <<END
          Host staging
            HostName $SSH_HOST
            User $SSH_USER
            Port $SSH_PORT
            IdentityFile ~/.ssh/staging.key
            StrictHostKeyChecking no
          END
        env:
          SSH_USER: ${{ secrets.SSH_USER }}
          SSH_KEY: ${{ secrets.SSH_KEY }}
          SSH_HOST: ${{ secrets.SSH_HOST }}
          SSH_PORT: ${{ secrets.SSH_PORT }}

      - name: Check out the source
        run: ssh staging "cd deployer && ./deploy.sh ${{ vars.TARGET_DOMAIN }}"

```

